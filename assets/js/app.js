import "../css/app.scss"
import "phoenix_html"
import EditorJS from '@editorjs/editorjs/dist/editor';
import Checklist from '@editorjs/simple-image/dist/bundle';
import Embed from '@editorjs/embed/dist/bundle';
import Header from '@editorjs/header/dist/bundle';
import List from '@editorjs/list/dist/bundle';
import Quote from '@editorjs/quote/dist/bundle';
import RawTool from '@editorjs/raw/dist/bundle';
import SimpleImage from '@editorjs/checklist/dist/bundle';

if (document.getElementById('editorjs')) {
  const editor = new EditorJS({
    holder: 'editorjs',
    tools: {
      header: {
        class: Header,
        inlineToolbar: ['link']
      },
      list: {
        class: List,
        inlineToolbar: true
      },
      raw: RawTool,
      image: SimpleImage,
      checklist: {
        class: Checklist,
        inlineToolbar: true,
      },
      embed: {
        class: Embed,
        config: {
          services: {
            youtube: true,
            coub: true
          }
        }
      },
      quote: Quote
    },
  })

  const saveButton = document.getElementById('save-button');
  const output = document.getElementById('article_body');

  saveButton.addEventListener('click', () => {
    editor.save().then(savedData => {
      output.value = savedData;
    })
  })
}