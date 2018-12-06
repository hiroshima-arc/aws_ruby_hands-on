import './stylesheets/main.css.scss'
import cornea_small from './images/corneal-small.png'
import './images/favicon.ico'

let imgHeader = document.createElement('img');
imgHeader.src = cornea_small;
document.getElementById('header').appendChild(imgHeader);