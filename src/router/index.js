import Vue from 'vue'
import Router from 'vue-router'
import LzIndex from '@/components/index'
import LzLogin from '@/components/login'
import LzRegister from '@/components/register'
import LzList from '@/components/list'
import LzDetail from '@/components/detail'
import LzPlay from '@/components/play'
import psCenter from '@/components/center'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      component: LzIndex
    },
    {
      path: '/index',
      component: LzIndex
    },
    {
      path: '/login',
      component: LzLogin
    },
    {
      path: '/register',
      component: LzRegister
    },
    {
      path: '/list/kw/:kw',
      component: LzList
    },
    {
      path: '/detail/:sid',
      component: LzDetail
    },
    {
      path: '/detail/:sid/:page',
      component: LzDetail
    },
    {
      path: '/play/:sid/:vid',
      component: LzPlay
    },
    {
      path: '/center',
      component: psCenter
    }
  ]
})
