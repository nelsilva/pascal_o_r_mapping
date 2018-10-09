#!/usr/bin/env python
# -*- coding: utf-8 -*
#                                                                              |
#  Author: Jean SUZINEAU <Jean.Suzineau@wanadoo.fr>                            |
#          http://www.mars42.com                                               |
#                                                                              |
#  Copyright 2018 Jean SUZINEAU - MARS42                                       |
#                                                                              |
#  This program is free software: you can redistribute it and/or modify        |
#  it under the terms of the GNU Lesser General Public License as published by |
#  the Free Software Foundation, either version 3 of the License, or           |
#  (at your option) any later version.                                         |
#                                                                              |
#  This program is distributed in the hope that it will be useful,             |
#  but WITHOUT ANY WARRANTY; without even the implied warranty of              |
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               |
#  GNU Lesser General Public License for more details.                         |
#                                                                              |
#  You should have received a copy of the GNU Lesser General Public License    |
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.       |
#                                                                              |

import math
import os
import sys
import cmath
#sys.path.append('/usr/share/inkscape/extensions')

import inkex
import simplestyle

__version__ = '0.2'

def complexes_to_points(cs):
    points=[]
    points.extend( [ (c.real,c.imag) for c in cs ])
    return points

def points_to_svgd(p, close=True):
    """ convert list of points (x,y) pairs
        into a closed SVG path list
    """
    f = p[0]
    p = p[1:]
    svgd = 'M%.4f,%.4f' % f
    for x in p:
        svgd += 'L%.4f,%.4f' % x
    if close:
        svgd += 'z'
    return svgd

class JupeEffect(inkex.Effect):
    def __init__(self):
        inkex.Effect.__init__(self)
        try:
            self.tty = open("/dev/tty", 'w')
        except:
            self.tty = open(os.devnull, 'w')  # '/dev/null' for POSIX, 'nul' for Windows.

        self.OptionParser.add_option('', '--active-tab'         , action = 'store', type = 'string', dest = 'active_tab'         , default = '0', help = '')
        self.OptionParser.add_option('', '--hauteur_av'         , action = 'store', type = 'float' , dest = 'hauteur_av'         , default = '0', help = '')
        self.OptionParser.add_option('', '--hauteur_ar'         , action = 'store', type = 'float' , dest = 'hauteur_ar'         , default = '0', help = '')
        self.OptionParser.add_option('', '--ourlet_bas'         , action = 'store', type = 'float' , dest = 'ourlet_bas'         , default = '0', help = '')
        self.OptionParser.add_option('', '--assemblage_ceinture', action = 'store', type = 'float' , dest = 'assemblage_ceinture', default = '0', help = '')
        self.OptionParser.add_option('', '--rayon_disque'       , action = 'store', type = 'float' , dest = 'rayon_disque'       , default = '0', help = '')
        self.OptionParser.add_option('', '--ogType'             , action = 'store', type = 'string', dest = 'ogType'             , default = '0', help = '')
    def effect(self):
        print >>self.tty, 'effect début'
        self.hauteur_av         = self.options.hauteur_av
        self.hauteur_ar         = self.options.hauteur_ar
        self.ourlet_bas         = self.options.ourlet_bas
        self.assemblage_ceinture= self.options.assemblage_ceinture
        self.rayon_disque       = self.options.rayon_disque
        self.ogType             = self.options.ogType

        self.rayon_av     = self.rayon_from_hauteur( self.hauteur_av)
        self.rayon_ar     = self.rayon_from_hauteur( self.hauteur_ar)
        self.rayon_cote   = (self.rayon_av+self.rayon_ar)/2
        self.rayon_cote_av=(self.rayon_cote+self.rayon_av)/2
        self.rayon_cote_ar=(self.rayon_cote+self.rayon_ar)/2

        self.uu_rayon_disque = self.uu_from_mm( self.rayon_disque )
        self.uu_rayon_av     = self.uu_from_mm( self.rayon_av     )
        self.uu_rayon_ar     = self.uu_from_mm( self.rayon_ar     )
        self.uu_rayon_cote   = self.uu_from_mm( self.rayon_cote   )
        self.uu_rayon_cote_av= self.uu_from_mm( self.rayon_cote_av)
        self.uu_rayon_cote_ar= self.uu_from_mm( self.rayon_cote_ar)
        self.uu_bord         = self.uu_from_mm( 100)

        #svg = self.current_layer
        svg = self.document.getroot()
        self.svg_text_FontHeight=24;

        # This finds center of current view in inkscape
        #t = 'translate(%s,%s)' % (self.view_center[0], self.view_center[1] )

        # Make a nice useful name
        g_attribs = { inkex.addNS('label','inkscape'): 'Patron Jupe',
                      #inkex.addNS('transform-center-x','inkscape'): str(-bbox_center[0]),
                      #inkex.addNS('transform-center-y','inkscape'): str(-bbox_center[1]),
                      #'transform': t,
                      'info':
                              'hauteur_av...: %f'        %(self.hauteur_av                    )
                             +'hauteur_ar...: %f'        %(self.hauteur_ar                    )
                             +'rayon_av.....: %f, 2*: %f'%(self.rayon_av     , 2*self.rayon_av     )
                             +'rayon_ar.....: %f, 2*: %f'%(self.rayon_ar     , 2*self.rayon_ar     )
                             +'rayon_cote...: %f, 2*: %f'%(self.rayon_cote   , 2*self.rayon_cote   )
                             +'rayon_cote_av: %f, 2*: %f'%(self.rayon_cote_av, 2*self.rayon_cote_av)
                             +'rayon_cote_ar: %f, 2*: %f'%(self.rayon_cote_ar, 2*self.rayon_cote_ar)
                    }
        # add the group to the document's current layer
        g = inkex.etree.SubElement(svg, 'g', g_attribs )
        print >>self.tty, 'effect'

        if   'ogType_Quartiers'              == self.ogType : self.Quartiers              ( g)
        elif 'ogType_Quartiers_non_complexes'== self.ogType : self.Quartiers_non_complexes( g)
        elif 'ogType_Quartiers_Ligne'        == self.ogType : self.Quartiers_Ligne        ( g)
        elif 'ogType_Quartiers_en_place'     == self.ogType : self.Quartiers_en_place     ( g)
        elif 'ogType_Moitie'                 == self.ogType : self.Moitie                 ( g)
        elif 'ogType_Complet'                == self.ogType : self.Complet                ( g)


    def Quartiers( self, _svg):
        print >>self.tty, 'Quartiers début'
        y=0;
        y=self.svg_Qc( _svg, self.uu_rayon_cote_ar, self.uu_rayon_cote   , y, 0)
        y=self.svg_Qc( _svg, self.uu_rayon_cote   , self.uu_rayon_cote_ar, y, 1)#coupure
        y=self.svg_Qc( _svg, self.uu_rayon_cote_ar, self.uu_rayon_ar     , y, 2)
        y=self.svg_Qc( _svg, self.uu_rayon_ar     , self.uu_rayon_cote_ar, y, 3)

        y=self.svg_Qc( _svg, self.uu_rayon_cote_av, self.uu_rayon_cote   , y, 4)
        y=self.svg_Qc( _svg, self.uu_rayon_cote   , self.uu_rayon_cote_av, y, 5)#coupure
        y=self.svg_Qc( _svg, self.uu_rayon_cote_av, self.uu_rayon_av     , y, 6)
        y=self.svg_Qc( _svg, self.uu_rayon_av     , self.uu_rayon_cote_av, y, 7)
        self.svg_Log_xy( _svg, 0, y)
    def Quartiers_non_complexes( self, _svg):
        print >>self.tty, 'Quartiers début'
        y=0;
        y=self.svg_Q( _svg, self.uu_rayon_cote_av, self.uu_rayon_cote   , y, 4)
        y=self.svg_Q( _svg, self.uu_rayon_cote   , self.uu_rayon_cote_av, y, 5)
        y=self.svg_Q( _svg, self.uu_rayon_cote_av, self.uu_rayon_av     , y, 6)
        y=self.svg_Q( _svg, self.uu_rayon_av     , self.uu_rayon_cote_av, y, 7)
        self.svg_Log_xy( _svg, 0, y)

        #self.Q4( _svg);
        #self.Q5( _svg);
        #self.Q6( _svg);
        #self.Q7( _svg);
        #self.Quartiers_Ligne( _svg)
    def Quartiers_Ligne( self, _svg):
        y=0;
        y_step=200

        cx= 2*self.uu_rayon_cote_av
        cy= self.uu_rayon_av
        #self.createGuide( cx, cy, 0)
        self.Q4( _svg, 'translate(%f,%f) rotate(%f,%f,%f)'%(-cx,y-cy,-135,cx,cy));

        y+=y_step;
        cx= 0#self.uu_rayon_cote_av
        cy= self.uu_rayon_av
        self.Q5( _svg, 'translate(%f,%f) rotate(%f,%f,%f)'%(3.0/2*self.uu_rayon_cote_av,y-cy,135,cx,cy));

        y+=y_step;
        cx= 0
        cy= self.uu_rayon_av
        self.Q6( _svg, 'translate(%f,%f) rotate(%f,%f,%f)'%(-cx,y-cy,+45,cx,cy));

        y+=y_step;
        cx= self.uu_rayon_cote_av
        cy= 0
        self.Q7( _svg, 'translate(%f,%f) rotate(%f,%f,%f)'%(-cx,y-cy,-45,cx,cy));

        y+=y_step
        self.svg_Log_xy( _svg, 0, y)
        #self.Q4( _svg);
        #self.Q5( _svg);
        #self.Q6( _svg);
        #self.Q7( _svg);

    def Quartiers_en_place( self, _svg):
        self.Q4( _svg);
        self.Q5( _svg);
        self.Q6( _svg);
        self.Q7( _svg);
        self.svg_Log_xy( _svg, self.uu_rayon_cote_av/4, self.uu_rayon_av+self.uu_rayon_disque)

    def Q4( self, _svg, _transform=''): self.svg_bord( _svg, self.uu_rayon_cote_av,self.uu_rayon_cote  , self.uu_rayon_cote_av, self.uu_rayon_av, 0, 1, 1, _transform, 'Q4')
    def Q5( self, _svg, _transform=''): self.svg_bord( _svg, self.uu_rayon_cote_av,self.uu_rayon_cote  , self.uu_rayon_cote_av, self.uu_rayon_av, 1, 1, 1, _transform, 'Q5')
    def Q6( self, _svg, _transform=''): self.svg_bord( _svg, self.uu_rayon_cote_av,self.uu_rayon_av    , self.uu_rayon_cote_av, self.uu_rayon_av, 2, 1, 1, _transform, 'Q6')
    def Q7( self, _svg, _transform=''): self.svg_bord( _svg, self.uu_rayon_cote_av,self.uu_rayon_av    , self.uu_rayon_cote_av, self.uu_rayon_av, 3, 1, 1, _transform, 'Q7')
    def Moitie( self, _svg):
        self.svg_text   ( _svg, self.uu_rayon_cote_av-self.uu_rayon_disque/2, self.uu_rayon_av, 'AV')
        self.svg_ellipse( _svg, self.uu_rayon_disque ,self.uu_rayon_disque, self.uu_rayon_cote_av, self.uu_rayon_av, 1, 2)
        self.svg_ellipse( _svg, self.uu_rayon_cote_av,self.uu_rayon_av    , self.uu_rayon_cote_av, self.uu_rayon_av, 2, 1)
        self.svg_ellipse( _svg, self.uu_rayon_cote_av,self.uu_rayon_cote  , self.uu_rayon_cote_av, self.uu_rayon_av, 1, 1)
        self.svg_Log_xy ( _svg, self.uu_rayon_cote_av/4, self.uu_rayon_av+self.uu_rayon_disque)

    def Complet( self, _svg):
        self.svg_text   ( _svg, self.uu_rayon_cote_av-self.uu_rayon_disque/2, self.uu_rayon_av, 'AV')
        self.svg_ellipse( _svg, self.uu_rayon_disque ,self.uu_rayon_disque, self.uu_rayon_cote_av, self.uu_rayon_av, 0,4)
        self.svg_ellipse( _svg, self.uu_rayon_cote_av,self.uu_rayon_av    , self.uu_rayon_cote_av, self.uu_rayon_av, 2,2)
        self.svg_ellipse( _svg, self.uu_rayon_cote_av,self.uu_rayon_cote  , self.uu_rayon_cote_av, self.uu_rayon_av, 0,2)
        self.svg_Log_xy ( _svg, self.uu_rayon_cote_av/4, self.uu_rayon_av+self.uu_rayon_disque)


    def svg_Log_xy( self, _svg, _x, _y):
        self.addline_x= _x
        self.addline_y= _y
        self.addline_text_height=14
        self.addline( _svg, 'hauteur_av...: %f'        %(self.hauteur_av                    ))
        self.addline( _svg, 'hauteur_ar...: %f'        %(self.hauteur_ar                    ))
        self.addline( _svg, 'rayon_av.....: %f, 2*: %f'%(self.rayon_av     , 2*self.rayon_av     ))
        self.addline( _svg, 'rayon_ar.....: %f, 2*: %f'%(self.rayon_ar     , 2*self.rayon_ar     ))
        self.addline( _svg, 'rayon_cote...: %f, 2*: %f'%(self.rayon_cote   , 2*self.rayon_cote   ))
        self.addline( _svg, 'rayon_cote_av: %f, 2*: %f'%(self.rayon_cote_av, 2*self.rayon_cote_av))
        self.addline( _svg, 'rayon_cote_ar: %f, 2*: %f'%(self.rayon_cote_ar, 2*self.rayon_cote_ar))
        #print >>self.tty,
    def uu_from_mm( self, _mm):
        return self.get_unittouu(str(_mm )+'mm')
    def rayon_from_hauteur( self, _hauteur):
        return self.rayon_disque+self.assemblage_ceinture+self.ourlet_bas+_hauteur
    def get_unittouu(self, param):
        " for 0.48 and 0.91 compatibility "
        try:
            return inkex.unittouu(param)
        except AttributeError:
            return self.unittouu(param)
    def svg_Q(self, _parent, _r1, _r2, _y, _numero):
        r = lambda i : _r1+i*(_r2-_r1)/90.0
        ri = lambda i : r(i)-self.uu_bord
        cosd= lambda i : math.cos( i*math.pi/180.0)
        sind= lambda i : math.sin( i*math.pi/180.0)
        a_from_i= lambda i : 180.0+45.0+i
        xexterieur= lambda i : r (i)*cosd(a_from_i(i))
        xinterieur= lambda i : ri(i)*cosd(a_from_i(i))
        yexterieur= lambda i : r (i)*sind(a_from_i(i))
        yinterieur= lambda i : ri(i)*sind(a_from_i(i))
        x0     = xexterieur( 0.0   )
        ytop   = yexterieur( 90.0/2)
        ybottom= yinterieur( 0.0   )
        yheight=ybottom-ytop
        points = []
        points.extend( [ (xexterieur(i),yexterieur(i)) for i in range( 0, 91    ) ])
        points.extend( [ (xinterieur(i),yinterieur(i)) for i in range(90, -1, -1) ])
        path = points_to_svgd( points )
        name= 'pQ%i'%(_numero)
        print >>self.tty, path
        style = {   'stroke'        : '#000000',
                    'stroke-width'  : '1',
                    'fill'          : 'none'            }
        mypath_attribs= {
                        'style'    : simplestyle.formatStyle(style),
                        'd'        : path,
                        'transform': 'translate(%f,%f)'%(-x0, _y-ytop)
                        }
        g_attribs = { inkex.addNS('label','inkscape'): name}
        g = inkex.etree.SubElement(_parent, 'g', g_attribs)

        p = inkex.etree.SubElement(g, inkex.addNS('path','svg'), mypath_attribs )
        self.svg_text( g, -x0, 2*self.svg_text_FontHeight, name, 'translate(%f,%f)'%(0,_y))
        return _y+yheight
    def svg_Qc(self, _parent, _r1, _r2, _y, _numero):
        r = lambda i : _r1+i*(_r2-_r1)/90.0
        ri = lambda i : r(i)-self.uu_bord
        d= lambda i : cmath.rect(1, i*math.pi/180.0)
        a_from_i= lambda i : 180.0+45.0+i
        exterieur= lambda i : r (i)*d(a_from_i(i))
        interieur= lambda i : ri(i)*d(a_from_i(i))
        p0 =exterieur(  0.0)
        p90=exterieur( 90.0)
        cMise_a_niveau=cmath.rect( 1, -cmath.phase( p90-p0))
        Mise_a_niveau= lambda c: ((c-p0)*cMise_a_niveau)+p0
        cs = []
        cs.extend( [ Mise_a_niveau(exterieur(i)) for i in range( 0, 91    ) ])
        cs.extend( [ Mise_a_niveau(interieur(i)) for i in range(90, -1, -1) ])
        pLeft  = min( cs, key= lambda c: c.real)
        pRight = max( cs, key= lambda c: c.real)
        ptop   = min( cs, key= lambda c: c.imag)
        pbottom= max( cs, key= lambda c: c.imag)
        pCentreHorizontal=(pLeft+pRight)/2;
        xCentre=400-pCentreHorizontal.real
        yheight=(pbottom-ptop).imag
        points = complexes_to_points( cs)
        path = points_to_svgd( points )
        name= 'pQ%i'%(_numero)
        print >>self.tty, path
        style = {   'stroke'        : '#000000',
                    'stroke-width'  : '1',
                    'fill'          : 'none'            }
        mypath_attribs= {
                        'style'    : simplestyle.formatStyle(style),
                        'd'        : path,
                        'transform': 'translate(%f,%f)'%(xCentre, _y-ptop.imag)
                        }
        g_attribs = { inkex.addNS('label','inkscape'): name}
        g = inkex.etree.SubElement(_parent, 'g', g_attribs)

        p = inkex.etree.SubElement(g, inkex.addNS('path','svg'), mypath_attribs )
        self.svg_text( g, xCentre, 2*self.svg_text_FontHeight, name, 'translate(%f,%f)'%(0,_y))
        return _y+yheight
    def svg_bord(self, _parent, _rx, _ry, _cx, _cy, _pi_2_start=0, _pi_2_length=4, _offset_disque=0, _transform='', _label=''):
        g_attribs = { inkex.addNS('label','inkscape'): _label}
        g = inkex.etree.SubElement(_parent, 'g', g_attribs)

        self.svg_ellipse( g, _rx, _ry, _cx, _cy, _pi_2_start, _pi_2_length, _offset_disque, _transform)
        self.svg_ellipse( g, _rx-self.uu_bord, _ry-self.uu_bord, _cx, _cy, _pi_2_start, _pi_2_length, _offset_disque, _transform)
    def svg_ellipse(self, _parent, _rx, _ry, _cx, _cy, _pi_2_start=0, _pi_2_length=4, _offset_disque=0, _transform=''):
        style = {   'stroke'        : '#FF0000',
                    'stroke-width'  : '1',
                    'fill'          : 'none'            }
        start = _pi_2_start *math.pi/2.0
        length= _pi_2_length*math.pi/2.0
        end= start + length
        ell_attribs = {'style':simplestyle.formatStyle(style),
            inkex.addNS('cx','sodipodi')        :str(_cx),
            inkex.addNS('cy','sodipodi')        :str(_cy),
            inkex.addNS('rx','sodipodi')        :str(_rx),
            inkex.addNS('ry','sodipodi')        :str(_ry),
            inkex.addNS('start','sodipodi')     :str(start),
            inkex.addNS('end','sodipodi')       :str(end  ),
            inkex.addNS('open','sodipodi')      :'true',    #all ellipse sectors we will draw are open
            inkex.addNS('type','sodipodi')      :'arc',
            'transform'                         :_transform
                }
        ell = inkex.etree.SubElement( _parent, inkex.addNS('path','svg'), ell_attribs)
        self.svg_text( _parent, _cx+95.0/100*_rx, _cy, 'eQ%i'%(4*_offset_disque+_pi_2_start), _transform+'translate(%f,%f) rotate(%f,%f,%f)'%(0,self.svg_text_FontHeight,start*180/math.pi+10,_cx,_cy))
    def svg_text( self, _parent, _cx, _cy, _text, transform=''):
        text_style = { 'font-size': str(self.svg_text_FontHeight),
                       'font-family': 'arial',
                       'text-anchor': 'middle',
                       'text-align': 'center',
                       'text-anchor':'middle',
                       'alignment-baseline':'central'
                       #'fill': path_stroke
                       }
        text_atts = {'style':simplestyle.formatStyle(text_style),
                     'x': str(_cx),
                     'y': str(_cy),
                     'transform':transform}
        text = inkex.etree.SubElement(_parent, 'text', text_atts)
        text.text = _text
    def add_text(self, node, text, position, text_height=24):
        """ Create and insert a single line of text into the svg under node.
        """
        line_style = {'font-size': '%dpx' % text_height, 'font-style':'normal', 'font-weight': 'normal',
                     #'fill': '#F6921E',
                     'font-family': 'Courier New',
                     'text-anchor': 'left',
                     'text-align': 'left'
                     }
        line_attribs = {inkex.addNS('label','inkscape'): 'Annotation',
                       'style': simplestyle.formatStyle(line_style),
                       'x': str(position[0]),
                       'y': str(position[1] + text_height)
                       }
        line = inkex.etree.SubElement(node, inkex.addNS('text','svg'), line_attribs)
        line.text = text
    def addline( self, _parent, _text):
        self.add_text( _parent, _text, [self.addline_x,self.addline_y], self.addline_text_height)
        self.addline_y+= self.addline_text_height * 1.2


e=JupeEffect()
e.affect()

