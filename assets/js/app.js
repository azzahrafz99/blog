import "../css/app.scss"
import "phoenix_html"
import EditorJS from '@editorjs/editorjs/dist/editor'; 
import Header from '@editorjs/header/dist/bundle';
import List from '@editorjs/list/dist/bundle';

const editor = new EditorJS({ 
  /** 
   * Id of Element that should contain the Editor 
   */ 
  holder: 'editorjs', 

  /** 
   * Available Tools list. 
   * Pass Tool's class or Settings object for each Tool you want to use 
   */ 
  tools: { 
    header: {
      class: Header, 
      inlineToolbar: ['link'] 
    }, 
    list: { 
      class: List, 
      inlineToolbar: true 
    } 
  }, 
})
