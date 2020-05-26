using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account1.Models;

namespace Account1.Controllers
{
    public class RoleController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: Role
        public ActionResult Index()
        {
           List<Roles> list =  db.Roles.ToList();
            return View(list);
        }
    }
}