export class Element
  {
  titre: string= '';
  action: string='';
  image: string= '';
  is_group: boolean=false;
  children: Array<Element>= [];

  constructor(values: Object = {})
    {
    Object.assign(this, values);
    }
  public get is_bouton()
    {
    return 0 == this.children.length;  
    }  
  }
export var Element_Vide= new Element({titre: "Element_Vide", action: "Element_Vide",image:"Element_Vide"});