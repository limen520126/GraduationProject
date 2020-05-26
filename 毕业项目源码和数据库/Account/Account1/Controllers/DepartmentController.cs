using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account1.Models;

namespace Account1.Controllers
{
    public class DepartmentController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: Department
        public ActionResult Index()
        {
            List<Departments> list = db.Departments.ToList(); 
            return View(list);
        }
    }
}