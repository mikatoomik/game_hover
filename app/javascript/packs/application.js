import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
import { loadDynamicBannerText } from '../components/banner';
import { initMapbox } from '../plugins/init_mapbox';


initMapbox();
if (document.querySelector('#banner-typed-text')) {
  loadDynamicBannerText();
}


