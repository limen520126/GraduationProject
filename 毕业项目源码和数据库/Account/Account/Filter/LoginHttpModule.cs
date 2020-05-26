using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Account.Filter
{
    public class LoginHttpModule : IHttpModule
    {
        /// <summary>
        /// 释放
        /// </summary>
        public void Dispose()
        {
            //throw new NotImplementedException();
        }

        /// <summary>
        /// 初始化入口
        /// </summary>
        /// <param name="context"></param>
        public void Init(HttpApplication context)
        {
            //获取当前请求相关联的状态，AcquireRequestState事件中，session可用 session["users"]
            context.AcquireRequestState += Context_AcquireRequestState;
            
        }

        /// <summary>
        /// 过滤器入口
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Context_AcquireRequestState(object sender, EventArgs e)
        {
            //获得http应用程序的请求
            HttpApplication app = sender as HttpApplication;
            //四个内置对象：request response  session  server
            //获得指定的信息
            HttpContext context = app.Context;
            //获得浏览器端请求的地址：https://localhost:44342/Menu/Index
            string url = context.Request.Url.ToString();
            if (url.ToLower().Contains("css")
                || url.ToLower().Contains("js")
                ||url.ToLower().Contains("png") 
                || url.ToLower().Contains("jpg")
                || url.ToLower().Contains("gif")
                || url.ToLower().Contains("fonts"))
            {
                return;
            }
            else
            {
                //判断url请求地址是否包含/home/login，.ToLower()转小写，Contains包含  ！不包含
                if (!url.ToLower().Contains("/home/login"))
                {
                    //判断用户是否登录
                    if (context.Session["user"] == null)
                    {
                        //如果没登陆，跳转到登录界面
                        context.Response.Redirect("/home/login");
                    }
                }
            }
            
        }
    }
}