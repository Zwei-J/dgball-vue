// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
//import axios from 'axios'

import VueResource from 'vue-resource';
//Vue.prototype.$http = axios;
Vue.use(VueResource);


import './assets/css/init.css'
import './assets/css/header.css'
import './assets/css/carousel.css'
import './assets/css/footer.css'
import './assets/js/jquery-1.11.3.js'
import './assets/js/jquery.carousel.js'
import './assets/js/jquery.nicescroll.min.js'
Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})
