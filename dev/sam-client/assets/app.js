import './stylesheets/main.css.scss'
import cornea_small from './images/corneal-small.png'
import './images/favicon.ico'
import './javascripts/hello'

let imgHeader = document.createElement('img');
imgHeader.src = cornea_small;
if (document.getElementById('header')) {
  document.getElementById('header').appendChild(imgHeader);
}