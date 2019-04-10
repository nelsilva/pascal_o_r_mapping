import {  Component,
          OnInit,
          Input,
                                 } from '@angular/core';
import { Router                  } from '@angular/router';

import { TResult_List} from '../uResult_List';
import { TsProject} from './usProject';
import { TeProject} from './ueProject';

@Component({
  selector: 'cProject',
  templateUrl: './ucProject.html',
  styleUrls: ['./ucProject.css'],
  providers: [TsProject],
  })

export class TcProject implements OnInit
  {
  @Input() id: number=-1;  
  public e: TeProject|null= null;
  public Projects: TResult_List<TeProject>;
  constructor(private router: Router, private service: TsProject)
    {
    }
  ngOnInit(): void
    {
    this.service.All()
      .then( _Projects =>
        {
        this.Projects= new TResult_List<TeProject>(_Projects);
        this.Projects.Elements.forEach( _e =>
          {
          _e.service= this.service;
          });
        });
    }
  onClick( _e: TeProject)
    {
    this.e= _e;
    this.e.modifie= true;
    }
  onKeyDown( event): void
    {
    if (13 === event.keyCode)
      {
      if (this.e)
        {
        this.e.Valide();
        }
      }
    }
  Projects_Nouveau()
    {
    this.service.Insert( new TeProject)
      .then( _e =>
        {
        this.Projects.Elements.push( _e);
        }
        );
    }
  }

