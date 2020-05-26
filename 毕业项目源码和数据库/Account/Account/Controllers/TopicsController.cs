using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Account.Models;

namespace Account.Controllers
{
    public class TopicsController : Controller
    {
        private AccountDBEntities db = new AccountDBEntities();

        // GET: Topics
        public ActionResult Index()
        {
            var topic = db.Topic.Include(t => t.Paper);
            return View(topic.ToList());
        }

        // GET: Topics/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Topic topic = db.Topic.Find(id);
            if (topic == null)
            {
                return HttpNotFound();
            }
            return View(topic);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id">试卷ID</param>
        /// <returns></returns>
        // GET: Topics/Create
        public ActionResult Create(int? id)
        {
            List<SelectListItem> listType = new List<SelectListItem>() {
             new SelectListItem(){ Value="1", Text="单选",Selected=true},
             new SelectListItem(){ Value="2", Text="判断"},
             new SelectListItem(){ Value="3", Text="问答"}
            };
            ViewBag.Paper = db.Paper.Find(id);
            ViewBag.TopicType = new SelectList(listType, "Value", "Text");
            
            return View();
        }

        // POST: Topics/Create
        // 为了防止“过多发布”攻击，请启用要绑定到的特定属性，有关 
        // 详细信息，请参阅 https://go.microsoft.com/fwlink/?LinkId=317598。
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "TopicID,TopicExplain,TopicScore,TopicType,TopicA,TopicB,TopicC,TopicD,TopicSort,TopicAnswer,PaperID")] Topic topic)
        {
            if (ModelState.IsValid)
            {
                db.Topic.Add(topic);
                db.SaveChanges();
                return RedirectToAction("Index","Papers");
            }
            
            List<SelectListItem> listType = new List<SelectListItem>() {
             new SelectListItem(){ Value="1", Text="单选",Selected=true},
             new SelectListItem(){ Value="2", Text="判断"},
             new SelectListItem(){ Value="3", Text="问答"}
            };
            ViewBag.Paper = db.Paper.Find(topic.PaperID);
            ViewBag.TopicType = new SelectList(listType, "Value", "Text");
            return View(topic);
        }

        // GET: Topics/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Topic topic = db.Topic.Find(id);
            if (topic == null)
            {
                return HttpNotFound();
            }
            List<SelectListItem> listType = new List<SelectListItem>() {
             new SelectListItem(){ Value="1", Text="单选",Selected=true},
             new SelectListItem(){ Value="2", Text="判断"},
             new SelectListItem(){ Value="3", Text="问答"}
            };
            ViewBag.Paper = db.Paper.Find(topic.PaperID);
            ViewBag.TopicType = new SelectList(listType, "Value", "Text", topic.TopicType);
            return View(topic);
        }

        // POST: Topics/Edit/5
        // 为了防止“过多发布”攻击，请启用要绑定到的特定属性，有关 
        // 详细信息，请参阅 https://go.microsoft.com/fwlink/?LinkId=317598。
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "TopicID,TopicExplain,TopicScore,TopicType,TopicA,TopicB,TopicC,TopicD,TopicSort,TopicAnswer,PaperID")] Topic topic)
        {
            if (ModelState.IsValid)
            {
                db.Entry(topic).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index", "Papers");
            }
            List<SelectListItem> listType = new List<SelectListItem>() {
             new SelectListItem(){ Value="1", Text="单选",Selected=true},
             new SelectListItem(){ Value="2", Text="判断"},
             new SelectListItem(){ Value="3", Text="问答"}
            };
            ViewBag.Paper = db.Paper.Find(topic.PaperID);
            ViewBag.TopicType = new SelectList(listType, "Value", "Text", topic.TopicType);
            return View(topic);
        }

        // GET: Topics/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Topic topic = db.Topic.Find(id);
            if (topic == null)
            {
                return HttpNotFound();
            }
            return View(topic);
        }

        // POST: Topics/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
          List<Detail> dlist =  db.Detail.Where(a => a.TopicID == id).ToList();
            Topic topic = db.Topic.Find(id);
            if (dlist.Count>0)
            {
                ModelState.AddModelError("flag", "该题已有学生作答不可删除！");
             }
            else
            {
                
                db.Topic.Remove(topic);
                db.SaveChanges();
                return RedirectToAction("Index", "Papers");
            }

            return View(topic);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
