using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Account.Filter
{
    
    /// <summary>
    /// 特性类，特点是以Attribute结尾
    /// ActionFilterAttribute把过滤器作为特性类使用
    /// </summary>
    public class LoginAttribute:ActionFilterAttribute
    {
        
        /// <summary>
        /// 重写父类的请求正在接收时处理的方法
        /// </summary>
        /// <param name="filterContext"></param>
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            //当请求标记的模块时，负责判断session是否为空，用户是否已登录
            if (HttpContext.Current.Session["user"] == null)
            {
               
                filterContext.Result = new RedirectResult("/Home/Login");
                
                
            }
        }
    }
}