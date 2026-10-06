<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
<title>فيديوز</title>

<style>
*{
 box-sizing:border-box;
 margin:0;
 padding:0;
 font-family:Arial,Tahoma,sans-serif;
}

html,body{
 width:100%;
 height:100%;
 background:#000;
 color:#fff;
 overflow:hidden;
}

button,input,textarea{
 font-family:inherit;
}

button{
 border:0;
 cursor:pointer;
}

.hidden{
 display:none!important;
}

/* ================= التطبيق ================= */

#app{
 width:100%;
 height:100%;
 background:#000;
}

/* ================= البداية ================= */

#splash{
 position:fixed;
 inset:0;
 z-index:99999;
 background:#000;
 display:flex;
 flex-direction:column;
 align-items:center;
 justify-content:center;
}

.logo{
 width:95px;
 height:95px;
 border-radius:28px;
 background:linear-gradient(135deg,#ff0050,#00f2ea);
 display:flex;
 align-items:center;
 justify-content:center;
 font-size:48px;
 font-weight:bold;
}

#splash h1{
 margin-top:18px;
 font-size:38px;
}

#splash p{
 color:#888;
 margin-top:7px;
}

.loader{
 width:150px;
 height:4px;
 background:#222;
 border-radius:20px;
 margin-top:25px;
 overflow:hidden;
}

.loader span{
 display:block;
 width:0;
 height:100%;
 background:linear-gradient(90deg,#ff0050,#00f2ea);
 animation:loading 2s forwards;
}

@keyframes loading{
 to{width:100%}
}

/* ================= الصفحات ================= */

.page{
 display:none;
 width:100%;
 height:calc(100% - 65px);
 overflow:hidden;
}

.page.active{
 display:block;
}

/* ================= الفيديوهات ================= */

.feed{
 width:100%;
 height:100%;
 overflow-y:auto;
 scroll-snap-type:y mandatory;
}

.video{
 width:100%;
 height:100%;
 min-height:100%;
 position:relative;
 overflow:hidden;
 scroll-snap-align:start;
 background:#111;
}

.video:nth-child(1){
 background:radial-gradient(circle,#ff0050,#150007,#000);
}

.video:nth-child(2){
 background:radial-gradient(circle,#00d9df,#001719,#000);
}

.video:nth-child(3){
 background:radial-gradient(circle,#743cff,#10001c,#000);
}

.fakeVideo{
 position:absolute;
 inset:0;
 display:flex;
 align-items:center;
 justify-content:center;
 font-size:100px;
}

.video::after{
 content:"";
 position:absolute;
 inset:0;
 background:linear-gradient(
  transparent 35%,
  transparent 55%,
  rgba(0,0,0,.9)
 );
 pointer-events:none;
}

.videoTop{
 position:absolute;
 top:15px;
 left:0;
 right:0;
 z-index:5;
 text-align:center;
}

.videoTop span{
 margin:0 15px;
 color:#aaa;
}

.videoTop .active{
 color:#fff;
 font-weight:bold;
 border-bottom:2px solid #fff;
 padding-bottom:7px;
}

.videoInfo{
 position:absolute;
 right:18px;
 bottom:25px;
 z-index:6;
 max-width:75%;
}

.videoInfo h3{
 margin-bottom:8px;
}

.videoInfo p{
 color:#ddd;
}

.actions{
 position:absolute;
 left:12px;
 bottom:40px;
 z-index:7;
 display:flex;
 flex-direction:column;
 gap:14px;
}

.action{
 background:none;
 color:#fff;
 text-align:center;
}

.actionIcon{
 width:48px;
 height:48px;
 border-radius:50%;
 background:#0008;
 display:flex;
 align-items:center;
 justify-content:center;
 font-size:22px;
}

.action small{
 display:block;
 margin-top:3px;
}

.liked{
 color:#ff0050!important;
}

/* ================= الشريط السفلي ================= */

.bottomNav{
 position:fixed;
 left:0;
 right:0;
 bottom:0;
 height:65px;
 z-index:100;
 background:#080808;
 border-top:1px solid #222;
 display:flex;
 justify-content:space-around;
 align-items:center;
}

.bottomNav button{
 background:none;
 color:#888;
 font-size:11px;
}

.bottomNav button span{
 display:block;
 font-size:23px;
 margin-bottom:2px;
}

.bottomNav button.active{
 color:#fff;
}

.cameraPlus{
 width:50px!important;
 height:36px;
 border-radius:10px!important;
 background:#fff!important;
 color:#000!important;
 font-size:27px!important;
 font-weight:bold;
}

/* ================================================= */
/*                  شاشة إنشاء المحتوى                */
/* ================================================= */

#createScreen{
 position:fixed;
 inset:0;
 z-index:1000;
 background:#000;
 display:none;
 overflow:hidden;
}

#createScreen.active{
 display:block;
}

/* الكاميرا الحقيقية */

#cameraVideo{
 position:absolute;
 inset:0;
 width:100%;
 height:100%;
 object-fit:cover;
 background:#111;
}

/* طبقة الكاميرا */

.cameraOverlay{
 position:absolute;
 inset:0;
 z-index:3;
 pointer-events:none;
}

.cameraOverlay button{
 pointer-events:auto;
}

/* ================= أعلى الكاميرا ================= */

.cameraTop{
 position:absolute;
 top:15px;
 left:15px;
 right:15px;
 display:flex;
 align-items:center;
 justify-content:space-between;
 pointer-events:auto;
}

.cameraClose,
.flipCamera{
 width:43px;
 height:43px;
 border-radius:50%;
 background:#0009;
 color:#fff;
 font-size:23px;
}

.cameraTitle{
 font-weight:bold;
 font-size:18px;
}

/* ================= الساوند ================= */

.soundButton{
 position:absolute;
 top:15px;
 left:50%;
 transform:translateX(-50%);
 z-index:40;

 min-width:150px;
 height:42px;

 padding:0 18px;

 border-radius:24px;
 border:1px solid #ffffff35;

 background:#000a;
 color:#fff;

 display:flex;
 align-items:center;
 justify-content:center;
 gap:7px;

 font-size:14px;
 font-weight:bold;

 backdrop-filter:blur(10px);
}

/* ================= أدوات الجانب ================= */

.sideTools{
 position:absolute;
 right:12px;
 top:115px;
 display:flex;
 flex-direction:column;
 gap:12px;
 z-index:10;
}

.sideTool{
 width:50px;
 min-height:50px;
 border-radius:25px;
 background:#0009;
 color:#fff;
 display:flex;
 flex-direction:column;
 align-items:center;
 justify-content:center;
 font-size:20px;
}

.sideTool small{
 font-size:9px;
 margin-top:2px;
}

.sideTool.selected{
 background:#fff;
 color:#000;
}

/* ================= الفلاتر ================= */

.filtersPanel{
 position:absolute;
 right:70px;
 top:110px;
 width:205px;
 background:#080808dd;
 border-radius:18px;
 padding:12px;
 z-index:30;
 backdrop-filter:blur(10px);
}

.filtersPanel h3{
 font-size:14px;
 margin-bottom:10px;
}

.filters{
 display:flex;
 gap:8px;
 overflow-x:auto;
}

.filter{
 min-width:50px;
 height:50px;
 border-radius:12px;
 border:2px solid transparent;
}

.filter.active{
 border-color:#fff;
}

.filterNormal{
 background:linear-gradient(135deg,#222,#777);
}

.filterWarm{
 background:linear-gradient(135deg,#ff5c35,#ffd36a);
}

.filterCool{
 background:linear-gradient(135deg,#00e5ff,#1c3cff);
}

.filterPink{
 background:linear-gradient(135deg,#ff0080,#7d00ff);
}

.filterBW{
 background:linear-gradient(135deg,#000,#fff);
}

.filterGreen{
 background:linear-gradient(135deg,#00ff88,#004422);
}

/* ================= نوع المحتوى ================= */

.createModes{
 position:absolute;
 bottom:170px;
 left:0;
 right:0;
 z-index:15;

 display:flex;
 justify-content:center;
 align-items:center;
 gap:15px;

 overflow-x:auto;
 padding:0 15px;
}

.createMode{
 color:#aaa;
 background:none;
 font-size:13px;
 white-space:nowrap;
}

.createMode.active{
 color:#fff;
 font-weight:bold;
}

/* ================= المدة ================= */

.durationBar{
 position:absolute;
 bottom:130px;
 left:0;
 right:0;
 z-index:15;

 display:flex;
 justify-content:center;
 gap:8px;
}

.duration{
 padding:8px 13px;
 border-radius:20px;
 background:#0009;
 color:#aaa;
 font-size:12px;
}

.duration.active{
 background:#fff;
 color:#000;
 font-weight:bold;
}

/* ================= المعرض ================= */

.galleryButton{
 position:absolute;
 left:20px;
 bottom:85px;
 z-index:20;

 width:55px;
 height:55px;

 border-radius:14px;

 background:#000a;
 color:#fff;

 font-size:25px;
}

#galleryInput{
 display:none;
}

/* ================= زر التسجيل ================= */

.recordArea{
 position:absolute;
 bottom:68px;
 left:0;
 right:0;
 z-index:20;

 display:flex;
 justify-content:center;
 align-items:center;
}

.recordButton{
 width:78px;
 height:78px;
 border-radius:50%;

 background:#fff;

 border:7px solid #bbb;

 box-shadow:0 0 0 4px #fff5;
}

.recordButton.recording{
 background:#ff0050;
 transform:scale(.9);
}

.recordButton.recording::after{
 content:"";
 display:block;

 width:25px;
 height:25px;

 background:#fff;
 border-radius:5px;

 margin:auto;
}

/* ================= العداد ================= */

.recordTimer{
 position:absolute;
 top:70px;
 left:50%;
 transform:translateX(-50%);

 z-index:50;

 background:#ff0050;

 padding:5px 12px;

 border-radius:20px;

 font-size:12px;

 display:none;
}

/* ================= شاشة السماح ================= */

#cameraPermission{
 position:absolute;
 inset:0;
 z-index:999;

 display:none;

 align-items:center;
 justify-content:center;

 background:#000;

 padding:25px;

 text-align:center;
}

.permissionBox{
 width:100%;
 max-width:370px;

 background:#181818;

 border-radius:25px;

 padding:28px 22px;
}

.permissionIcon{
 font-size:60px;
 margin-bottom:15px;
}

.permissionBox p{
 color:#aaa;
 line-height:1.8;
 margin:12px 0 20px;
}

.permissionButton{
 width:100%;
 height:52px;

 border-radius:14px;

 background:#ff0050;
 color:#fff;

 font-size:17px;
 font-weight:bold;
}

.permissionCancel{
 width:100%;
 height:45px;

 margin-top:8px;

 border-radius:14px;

 background:#292929;
 color:#fff;
}

/* ================= محرر النص ================= */

.textCreator{
 position:absolute;
 inset:0;

 z-index:100;

 background:#000;

 display:none;
 flex-direction:column;
}

.textCreator.active{
 display:flex;
}

.textTop{
 padding:15px;

 display:flex;
 justify-content:space-between;
 align-items:center;
}

.textInput{
 flex:1;

 height:60%;

 margin:20px;

 background:transparent;

 border:0;
 outline:0;

 color:#fff;

 font-size:32px;

 text-align:center;

 resize:none;
}

.textDone{
 background:#fff;
 color:#000;

 padding:10px 20px;

 border-radius:20px;
}

/* ================= المعاينة ================= */

.previewScreen{
 position:absolute;
 inset:0;

 z-index:200;

 background:#000;

 display:none;
 flex-direction:column;
}

.previewScreen.active{
 display:flex;
}

.previewHeader{
 height:60px;

 display:flex;
 align-items:center;
 justify-content:space-between;

 padding:10px 15px;
}

.previewMedia{
 flex:1;

 display:flex;
 align-items:center;
 justify-content:center;

 overflow:hidden;
}

.previewMedia video,
.previewMedia img{
 max-width:100%;
 max-height:100%;

 object-fit:contain;
}

.previewBottom{
 padding:15px;

 display:flex;

 gap:10px;
}

.publishButton{
 flex:1;

 height:50px;

 border-radius:12px;

 background:#ff0050;
 color:#fff;

 font-weight:bold;
}

.backButton{
 width:100px;

 height:50px;

 border-radius:12px;

 background:#222;
 color:#fff;
}

/* ================= لوحة الساوند ================= */

.soundPanel{
 position:absolute;
 inset:0;

 z-index:150;

 background:#080808;

 display:none;
 flex-direction:column;
}

.soundPanel.active{
 display:flex;
}

.soundHeader{
 height:65px;

 display:flex;
 align-items:center;
 justify-content:space-between;

 padding:10px 15px;

 border-bottom:1px solid #222;
}

.soundClose{
 width:40px;
 height:40px;

 border-radius:50%;

 background:#222;
 color:#fff;

 font-size:20px;
}

.soundSearch{
 margin:12px;

 padding:13px;

 border-radius:13px;

 background:#191919;

 border:1px solid #333;

 color:#fff;

 outline:none;
}

.soundList{
 flex:1;

 overflow-y:auto;

 padding:0 12px 30px;
}

.soundCategory{
 margin:15px 5px 8px;

 color:#aaa;

 font-size:12px;
}

.soundItem{
 width:100%;

 min-height:65px;

 background:#171717;

 color:#fff;

 border-radius:14px;

 margin-bottom:8px;

 display:flex;

 align-items:center;

 gap:12px;

 padding:10px 13px;

 text-align:right;
}

.soundIcon{
 width:43px;
 height:43px;

 border-radius:12px;

 background:linear-gradient(135deg,#ff0050,#7b00ff);

 display:flex;
 align-items:center;
 justify-content:center;

 font-size:21px;

 flex-shrink:0;
}

.soundItem b{
 display:block;
}

.soundItem small{
 color:#888;
 display:block;
 margin-top:3px;
}

/* ================= الصفحات البسيطة ================= */

.simplePage{
 padding:25px 20px;

 overflow:auto;

 height:100%;
}

.searchInput{
 width:100%;

 padding:14px;

 border-radius:13px;

 background:#191919;

 border:1px solid #333;

 color:#fff;

 outline:none;
}

.card{
 background:#171717;

 border-radius:15px;

 padding:18px;

 margin-top:15px;
}

/* ================= الحساب ================= */

.profile{
 text-align:center;

 padding:25px 18px 100px;

 overflow:auto;

 height:100%;
}

.avatar{
 width:105px;
 height:105px;

 border-radius:50%;

 margin:20px auto 12px;

 background:linear-gradient(135deg,#ff0050,#00f2ea);

 display:flex;
 align-items:center;
 justify-content:center;

 overflow:hidden;

 font-size:40px;

 border:2px solid #fff;
}

.avatar img{
 width:100%;
 height:100%;
 object-fit:cover;
}

.profile h2{
 margin-top:8px;
}

.username{
 color:#888;
 margin-top:5px;
}

.bio{
 color:#ddd;

 margin:12px auto;

 max-width:350px;
}

.stats{
 display:flex;

 justify-content:center;

 gap:35px;

 margin:25px 0;
}

.stats b{
 display:block;

 font-size:20px;
}

.stats span{
 color:#888;

 font-size:11px;
}

.editButton{
 background:#222;

 color:#fff;

 border-radius:10px;

 padding:12px 40px;
}

.socials{
 display:flex;

 flex-wrap:wrap;

 justify-content:center;

 gap:8px;

 margin-top:20px;
}

.social{
 background:#191919;

 color:#fff;

 text-decoration:none;

 padding:9px 13px;

 border-radius:20px;

 font-size:12px;
}

/* ================= تسجيل الدخول ================= */

.modal{
 position:fixed;
 inset:0;

 z-index:3000;

 background:#000c;

 display:flex;

 align-items:flex-end;
}

.loginBox{
 width:100%;

 max-width:500px;

 max-height:92%;

 overflow:auto;

 background:#151515;

 border-radius:27px 27px 0 0;

 padding:25px 20px 35px;
}

.close{
 float:left;

 width:35px;
 height:35px;

 border-radius:50%;

 background:#292929;

 color:#fff;

 font-size:20px;
}

.loginLogo{
 width:65px;
 height:65px;

 border-radius:19px;

 background:linear-gradient(135deg,#ff0050,#00f2ea);

 display:flex;

 align-items:center;
 justify-content:center;

 margin:10px auto 15px;

 font-size:32px;

 font-weight:bold;
}

.loginBox h2{
 text-align:center;
}

.subtitle{
 text-align:center;

 color:#888;

 font-size:13px;

 margin:8px 0 20px;
}

.loginButton{
 width:100%;

 height:52px;

 border-radius:11px;

 margin-bottom:10px;

 font-weight:bold;
}

.phoneLogin{
 background:#ff0050;
 color:#fff;
}

.googleLogin{
 background:#fff;
 color:#222;
}

.facebookLogin{
 background:#1877f2;
 color:#fff;
}

.input{
 width:100%;

 padding:14px;

 background:#222;

 border:1px solid #333;

 color:#fff;

 border-radius:10px;

 outline:none;

 margin-bottom:12px;
}

.continue{
 width:100%;

 height:50px;

 border-radius:10px;

 background:#ff0050;

 color:#fff;

 font-weight:bold;
}

.back{
 width:100%;

 height:45px;

 background:none;

 color:#888;
}

/* ================= تعديل الحساب ================= */

.editBox{
 width:100%;

 max-width:500px;

 max-height:94%;

 overflow:auto;

 background:#151515;

 border-radius:25px 25px 0 0;

 padding:25px 20px 35px;
}

.editBox h2{
 text-align:center;

 margin-bottom:20px;
}

.editAvatar{
 width:95px;
 height:95px;

 border-radius:50%;

 margin:0 auto 10px;

 background:#222;

 display:flex;

 align-items:center;
 justify-content:center;

 overflow:hidden;

 font-size:35px;
}

.editAvatar img{
 width:100%;
 height:100%;
 object-fit:cover;
}

.changePhoto{
 display:block;

 margin:0 auto 20px;

 background:none;

 color:#00e5ff;
}

.saveButton{
 width:100%;

 height:50px;

 background:#ff0050;

 color:#fff;

 border-radius:10px;

 font-weight:bold;
}

/* ================= Toast ================= */

.toast{
 position:fixed;

 z-index:10000;

 left:50%;

 bottom:85px;

 transform:translateX(-50%);

 background:#fff;

 color:#000;

 padding:12px 20px;

 border-radius:25px;

 white-space:nowrap;
}
</style>
</head>

<body>

<!-- ================= البداية ================= -->

<div id="splash">

 <div class="logo">ف</div>

 <h1>فيديوز</h1>

 <p>شاهد • شارك • استمتع</p>

 <div class="loader">
  <span></span>
 </div>

</div>

<div id="app">

<!-- ================= الرئيسية ================= -->

<section class="page active" id="home">

 <div class="feed">

  <div class="video">

   <div class="fakeVideo">🎬</div>

   <div class="videoTop">
    <span>المتابَعون</span>
    <span class="active">لك</span>
   </div>

   <div class="videoInfo">
    <h3>@videoz</h3>
    <p>أهلاً بكم في فيديوز ❤️</p>
   </div>

   <div class="actions">

    <button class="action" onclick="like(this)">
     <div class="actionIcon">♥</div>
     <small>1.2K</small>
    </button>

    <button class="action" onclick="comment()">
     <div class="actionIcon">💬</div>
     <small>235</small>
    </button>

    <button class="action" onclick="saveVideo(this)">
     <div class="actionIcon">🔖</div>
     <small>80</small>
    </button>

    <button class="action" onclick="shareVideo()">
     <div class="actionIcon">↗</div>
     <small>مشاركة</small>
    </button>

   </div>

  </div>


  <div class="video">

   <div class="fakeVideo">🔥</div>

   <div class="videoInfo">
    <h3>@creator</h3>
    <p>فيديو جديد 🔥 #ترند</p>
   </div>

   <div class="actions">

    <button class="action" onclick="like(this)">
     <div class="actionIcon">♥</div>
     <small>5.8K</small>
    </button>

    <button class="action" onclick="comment()">
     <div class="actionIcon">💬</div>
     <small>400</small>
    </button>

    <button class="action" onclick="saveVideo(this)">
     <div class="actionIcon">🔖</div>
     <small>90</small>
    </button>

    <button class="action" onclick="shareVideo()">
     <div class="actionIcon">↗</div>
     <small>مشاركة</small>
    </button>

   </div>

  </div>


  <div class="video">

   <div class="fakeVideo">😎</div>

   <div class="videoInfo">
    <h3>@user</h3>
    <p>شوفوا الفيديو الجديد 😍</p>
   </div>

   <div class="actions">

    <button class="action" onclick="like(this)">
     <div class="actionIcon">♥</div>
     <small>2.1K</small>
    </button>

    <button class="action" onclick="comment()">
     <div class="actionIcon">💬</div>
     <small>210</small>
    </button>

    <button class="action" onclick="saveVideo(this)">
     <div class="actionIcon">🔖</div>
     <small>42</small>
    </button>

    <button class="action" onclick="shareVideo()">
     <div class="actionIcon">↗</div>
     <small>مشاركة</small>
    </button>

   </div>

  </div>

 </div>

</section>


<!-- ================= اكتشاف ================= -->

<section class="page" id="searchPage">

 <div class="simplePage">

  <h2>اكتشاف</h2>

  <br>

  <input
   class="searchInput"
   placeholder="ابحث عن حساب أو هاشتاج">

  <div class="card">🔥 #ترند</div>
  <div class="card">🎵 #موسيقى</div>
  <div class="card">😂 #مضحك</div>

 </div>

</section>


<!-- ================= الوارد ================= -->

<section class="page" id="messagesPage">

 <div class="simplePage">

  <h2>الوارد</h2>

  <div class="card">
   👋 مرحباً بك في فيديوز
  </div>

 </div>

</section>


<!-- ================= الحساب ================= -->

<section class="page" id="profilePage">

 <div class="profile">

  <h2>الحساب</h2>

  <div class="avatar" id="profileAvatar">
   👤
  </div>

  <h2 id="profileName">زائر</h2>

  <div class="username" id="profileUsername">
   لم تسجل الدخول
  </div>

  <div class="bio" id="profileBio"></div>

  <div class="stats">

   <div>
    <b>0</b>
    <span>متابعون</span>
   </div>

   <div>
    <b>0</b>
    <span>متابَعون</span>
   </div>

   <div>
    <b>0</b>
    <span>إعجابات</span>
   </div>

  </div>

  <button
   class="editButton"
   id="profileButton"
   onclick="profileAction()">
   تسجيل الدخول
  </button>

  <div class="socials" id="socials"></div>

 </div>

</section>


<!-- ================= التنقل ================= -->

<nav class="bottomNav">

 <button
  class="active"
  onclick="openPage('home',this)">
  <span>⌂</span>
  الرئيسية
 </button>

 <button
  onclick="openPage('searchPage',this)">
  <span>⌕</span>
  اكتشاف
 </button>

 <button
  class="cameraPlus"
  onclick="openCreator()">
  +
 </button>

 <button
  onclick="openPage('messagesPage',this)">
  <span>♡</span>
  الوارد
 </button>

 <button
  onclick="openPage('profilePage',this)">
  <span>👤</span>
  الحساب
 </button>

</nav>

</div>


<!-- ================================================= -->
<!--                  شاشة إنشاء المحتوى                -->
<!-- ================================================= -->

<div id="createScreen">

 <video
  id="cameraVideo"
  autoplay
  playsinline
  muted>
 </video>


 <div class="cameraOverlay">


  <!-- الساوند -->

  <button
   id="selectedSoundButton"
   class="soundButton"
   onclick="openSounds()">
   🎵 الساوندات
  </button>


  <!-- أعلى الشاشة -->

  <div class="cameraTop">

   <button
    class="cameraClose"
    onclick="closeCreator()">
    ×
   </button>

   <div class="cameraTitle">
    إنشاء
   </div>

   <button
    class="flipCamera"
    onclick="flipCamera()">
    🔄
   </button>

  </div>


  <!-- أدوات الجانب -->

  <div class="sideTools">

   <button
    class="sideTool"
    onclick="toggleFilters()">
    ✨
    <small>فلاتر</small>
   </button>

   <button
    class="sideTool"
    onclick="toast('السرعة جاهزة')">
    ⚡
    <small>سرعة</small>
   </button>

   <button
    class="sideTool"
    onclick="toast('المؤقت جاهز')">
    ⏱
    <small>مؤقت</small>
   </button>

   <button
    class="sideTool"
    onclick="toggleBeauty(this)">
    💎
    <small>تجميل</small>
   </button>

   <button
    class="sideTool"
    onclick="toast('الفلاش يحتاج تطبيق Android أصلي')">
    🔦
    <small>فلاش</small>
   </button>

  </div>


  <!-- الفلاتر -->

  <div
   class="filtersPanel hidden"
   id="filtersPanel">

   <h3>الفلاتر</h3>

   <div class="filters">

    <button
     class="filter filterNormal active"
     onclick="applyFilter('normal',this)">
    </button>

    <button
     class="filter filterWarm"
     onclick="applyFilter('warm',this)">
    </button>

    <button
     class="filter filterCool"
     onclick="applyFilter('cool',this)">
    </button>

    <button
     class="filter filterPink"
     onclick="applyFilter('pink',this)">
    </button>

    <button
     class="filter filterBW"
     onclick="applyFilter('bw',this)">
    </button>

    <button
     class="filter filterGreen"
     onclick="applyFilter('green',this)">
    </button>

   </div>

  </div>


  <!-- نوع المحتوى -->

  <div class="createModes">

   <button
    class="createMode"
    onclick="selectMode('photo',this)">
    صورة
   </button>

   <button
    class="createMode"
    onclick="selectMode('text',this)">
    نص
   </button>

   <button
    class="createMode active"
    onclick="selectMode('video15',this)">
    فيديو 15ث
   </button>

   <button
    class="createMode"
    onclick="selectMode('video60',this)">
    فيديو 60ث
   </button>

   <button
    class="createMode"
    onclick="selectMode('video600',this)">
    فيديو 10د
   </button>

  </div>


  <!-- مدة الفيديو -->

  <div
   class="durationBar"
   id="durationBar">

   <button
    class="duration active"
    onclick="setDuration(15,this)">
    15ث
   </button>

   <button
    class="duration"
    onclick="setDuration(60,this)">
    60ث
   </button>

   <button
    class="duration"
    onclick="setDuration(600,this)">
    10د
   </button>

  </div>


  <!-- العداد -->

  <div
   class="recordTimer"
   id="recordTimer">
   00:00
  </div>


  <!-- المعرض -->

  <button
   class="galleryButton"
   onclick="openGallery()">
   🖼️
  </button>

  <input
   type="file"
   id="galleryInput"
   accept="image/*,video/*"
   onchange="gallerySelected(this)">


  <!-- زر التسجيل -->

  <div class="recordArea">

   <button
    class="recordButton"
    id="recordButton"
    onclick="recordAction()">
   </button>

  </div>

 </div>


 <!-- ================= رسالة الكاميرا ================= -->

 <div
  id="cameraPermission">

  <div class="permissionBox">

   <div class="permissionIcon">
    📷
   </div>

   <h2>
    السماح بالكاميرا
   </h2>

   <p>
    يحتاج فيديوز إلى استخدام الكاميرا والميكروفون
    لإنشاء الصور والفيديوهات.
   </p>

   <button
    class="permissionButton"
    onclick="tryCameraAgain()">
    السماح بالكاميرا
   </button>

   <button
    class="permissionCancel"
    onclick="closeCameraPermission()">
    إلغاء
   </button>

  </div>

 </div>


 <!-- ================= محرر النص ================= -->

 <div
  class="textCreator"
  id="textCreator">

  <div class="textTop">

   <button
    class="cameraClose"
    onclick="closeTextCreator()">
    ×
   </button>

   <b>إضافة نص</b>

   <button
    class="textDone"
    onclick="finishText()">
    تم
   </button>

  </div>

  <textarea
   class="textInput"
   id="textInput"
   placeholder="اكتب النص هنا..."></textarea>

 </div>


 <!-- ================= المعاينة ================= -->

 <div
  class="previewScreen"
  id="previewScreen">

  <div class="previewHeader">

   <button
    class="cameraClose"
    onclick="closePreview()">
    ×
   </button>

   <b>معاينة</b>

   <span></span>

  </div>

  <div
   class="previewMedia"
   id="previewMedia">
  </div>

  <div class="previewBottom">

   <button
    class="backButton"
    onclick="closePreview()">
    تعديل
   </button>

   <button
    class="publishButton"
    onclick="publishContent()">
    نشر
   </button>

  </div>

 </div>


 <!-- ================= الساوندات ================= -->

 <div
  class="soundPanel"
  id="soundPanel">

  <div class="soundHeader">

   <button
    class="soundClose"
    onclick="closeSounds()">
    ×
   </button>

   <b>اختيار الساوند</b>

   <span></span>

  </div>


  <input
   class="soundSearch"
   id="soundSearch"
   placeholder="ابحث عن ساوند..."
   oninput="searchSounds(this.value)">


  <div
   class="soundList"
   id="soundList">


   <div class="soundCategory">
    🎵 ساوندات
   </div>


   <button
    class="soundItem"
    data-name="ساوند شعبي 1"
    onclick="selectSound('ساوند شعبي 1')">

    <div class="soundIcon">
     🎵
    </div>

    <div>
     <b>ساوند شعبي 1</b>
     <small>موسيقى مرخّصة</small>
    </div>

   </button>


   <button
    class="soundItem"
    data-name="ساوند شعبي 2"
    onclick="selectSound('ساوند شعبي 2')">

    <div class="soundIcon">
     🎶
    </div>

    <div>
     <b>ساوند شعبي 2</b>
     <small>موسيقى مرخّصة</small>
    </div>

   </button>


   <button
    class="soundItem"
    data-name="ساوند ترند"
    onclick="selectSound('ساوند ترند')">

    <div class="soundIcon">
     🔥
    </div>

    <div>
     <b>ساوند ترند</b>
     <small>موسيقى مرخّصة</small>
    </div>

   </button>


   <div class="soundCategory">
    📖 القرآن الكريم
   </div>


   <button
    class="soundItem"
    data-name="قرآن كريم"
    onclick="selectSound('قرآن كريم')">

    <div class="soundIcon">
     📖
    </div>

    <div>
     <b>القرآن الكريم</b>
     <small>اختر ملفًا صوتيًا مرخّصًا للاستخدام</small>
    </div>

   </button>


   <button
    class="soundItem"
    data-name="تلاوة هادئة"
    onclick="selectSound('تلاوة هادئة')">

    <div class="soundIcon">
     🕌
    </div>

    <div>
     <b>تلاوة هادئة</b>
     <small>صوت متاح للاستخدام</small>
    </div>

   </button>

  </div>

 </div>

</div>


<!-- ================= تسجيل الدخول ================= -->

<div
 class="modal hidden"
 id="loginModal">

 <div class="loginBox">

  <button
   class="close"
   onclick="closeLogin()">
   ×
  </button>

  <div class="loginLogo">
   ف
  </div>

  <h2>
   تسجيل الدخول إلى فيديوز
  </h2>

  <p class="subtitle">
   اختر طريقة تسجيل الدخول
  </p>

  <button
   class="loginButton phoneLogin"
   onclick="showLoginForm('phone')">
   📱 تسجيل الدخول برقم الهاتف
  </button>

  <button
   class="loginButton googleLogin"
   onclick="showLoginForm('google')">
   G &nbsp; المتابعة باستخدام Google
  </button>

  <button
   class="loginButton facebookLogin"
   onclick="showLoginForm('facebook')">
   f &nbsp; المتابعة باستخدام Facebook
  </button>

 </div>

</div>


<!-- ================= نموذج تسجيل الدخول ================= -->

<div
 class="modal hidden"
 id="formModal">

 <div class="loginBox">

  <button
   class="close"
   onclick="closeLogin()">
   ×
  </button>

  <div
   class="loginLogo"
   id="formIcon">
   📱
  </div>

  <h2 id="formTitle">
   تسجيل الدخول
  </h2>

  <p
   class="subtitle"
   id="formSubtitle">
   أدخل بياناتك
  </p>

  <input
   class="input"
   id="loginEmail"
   placeholder="رقم الهاتف أو البريد الإلكتروني">

  <input
   class="input"
   id="loginPassword"
   type="password"
   placeholder="كلمة المرور">

  <button
   class="continue"
   onclick="performLogin()">
   تسجيل الدخول
  </button>

  <button
   class="back"
   onclick="backToLoginMethods()">
   رجوع
  </button>

 </div>

</div>


<!-- ================= تعديل الحساب ================= -->

<div
 class="modal hidden"
 id="editModal">

 <div class="editBox">

  <button
   class="close"
   onclick="closeEdit()">
   ×
  </button>

  <h2>
   تعديل الحساب
  </h2>

  <div
   class="editAvatar"
   id="editAvatar">
   👤
  </div>

  <input
   type="file"
   id="photoInput"
   accept="image/*"
   hidden
   onchange="changePhoto(this)">

  <button
   class="changePhoto"
   onclick="document.getElementById('photoInput').click()">
   تغيير صورة الحساب
  </button>

  <input
   class="input"
   id="editName"
   placeholder="اسم الحساب">

  <input
   class="input"
   id="editUsername"
   placeholder="اسم المستخدم">

  <textarea
   class="input"
   id="editBio"
   style="height:90px"
   placeholder="النبذة التعريفية"></textarea>

  <input
   class="input"
   id="youtube"
   placeholder="رابط YouTube">

  <input
   class="input"
   id="instagram"
   placeholder="رابط Instagram">

  <input
   class="input"
   id="telegram"
   placeholder="رابط Telegram">

  <input
   class="input"
   id="facebook"
   placeholder="رابط Facebook">

  <input
   class="input"
   id="tiktok"
   placeholder="رابط TikTok">

  <input
   class="input"
   id="website"
   placeholder="رابط إضافي">

  <button
   class="saveButton"
   onclick="saveProfile()">
   حفظ التعديلات
  </button>

 </div>

</div>


<script>

/* ================================================= */
/*                    المتغيرات                      */
/* ================================================= */

let account =
 JSON.parse(
  localStorage.getItem("videozAccount") || "null"
 );

let cameraStream = null;

let currentFacing = "user";

let currentDuration = 15;

let currentMode = "video15";

let recording = false;

let mediaRecorder = null;

let recordedChunks = [];

let timerInterval = null;

let elapsed = 0;

let recordingTimeout = null;

let selectedSound = "";


/* ================================================= */
/*                    البداية                        */
/* ================================================= */

setTimeout(function(){

 document
  .getElementById("splash")
  .classList.add("hidden");

},2200);


/* ================================================= */
/*                    التنقل                         */
/* ================================================= */

function openPage(id,btn){

 document
  .querySelectorAll(".page")
  .forEach(function(page){

   page.classList.remove("active");

  });

 const target =
  document.getElementById(id);

 if(target){
  target.classList.add("active");
 }

 document
  .querySelectorAll(".bottomNav button")
  .forEach(function(x){

   x.classList.remove("active");

  });

 if(btn){
  btn.classList.add("active");
 }

}


/* ================================================= */
/*                    الكاميرا                       */
/* ================================================= */

async function openCreator(){

 document
  .getElementById("createScreen")
  .classList.add("active");

 try{

  await startCamera();

 }catch(error){

  showCameraPermission();

 }

}


/* تشغيل الكاميرا */

async function startCamera(){

 if(
  !navigator.mediaDevices ||
  !navigator.mediaDevices.getUserMedia
 ){

  showCameraPermission();

  throw new Error(
   "getUserMedia غير متاح"
  );

 }

 try{

  if(cameraStream){

   cameraStream
    .getTracks()
    .forEach(function(track){

     track.stop();

    });

   cameraStream=null;
  }


  cameraStream =
   await navigator.mediaDevices
    .getUserMedia({

     video:{
      facingMode:{
       ideal:currentFacing
      },

      width:{
       ideal:1080
      },

      height:{
       ideal:1920
      }
     },

     audio:true

    });


  const video =
   document.getElementById("cameraVideo");


  video.srcObject =
   cameraStream;

  video.muted = true;

  video.playsInline = true;


  try{

   await video.play();

  }catch(e){

   console.log(
    "play() انتظار تفاعل المستخدم"
   );

  }


  closeCameraPermission();


 }catch(error){

  console.error(
   "Camera error:",
   error
  );

  showCameraPermission();

  throw error;

 }

}


/* إعادة طلب الكاميرا */

async function tryCameraAgain(){

 closeCameraPermission();

 await startCamera();

}


/* رسالة الصلاحية */

function showCameraPermission(){

 document
  .getElementById("cameraPermission")
  .style.display="flex";

}


/* إغلاق رسالة الصلاحية */

function closeCameraPermission(){

 document
  .getElementById("cameraPermission")
  .style.display="none";

}


/* تبديل الكاميرا */

async function flipCamera(){

 currentFacing =
  currentFacing==="user"
  ?"environment"
  :"user";

 try{

  await startCamera();

 }catch(e){

  toast("تعذر تشغيل الكاميرا");

 }

}


/* إغلاق الكاميرا */

function closeCreator(){

 stopRecording();

 if(recordingTimeout){

  clearTimeout(recordingTimeout);

  recordingTimeout=null;

 }


 if(cameraStream){

  cameraStream
   .getTracks()
   .forEach(function(track){

    track.stop();

   });

  cameraStream=null;

 }


 const camera =
  document.getElementById("cameraVideo");

 if(camera){

  camera.srcObject=null;

 }


 document
  .getElementById("createScreen")
  .classList.remove("active");


 document
  .getElementById("filtersPanel")
  .classList.add("hidden");


 document
  .getElementById("textCreator")
  .classList.remove("active");


 closeSounds();

}


/* ================================================= */
/*                    الساوند                        */
/* ================================================= */

function openSounds(){

 document
  .getElementById("soundPanel")
  .classList.add("active");

}

function closeSounds(){

 document
  .getElementById("soundPanel")
  .classList.remove("active");

}


function selectSound(name){

 selectedSound=name;

 document
  .getElementById("selectedSoundButton")
  .innerText="🎵 "+name;

 closeSounds();

 toast(
  "تم اختيار: "+name
 );

}


function searchSounds(value){

 const query =
  value
   .trim()
   .toLowerCase();

 document
  .querySelectorAll(".soundItem")
  .forEach(function(item){

   const name =
    item
     .dataset
     .name
     .toLowerCase();

   item.style.display =
    !query ||
    name.includes(query)
    ?"flex"
    :"none";

  });

}


/* ================================================= */
/*                    الفلاتر                        */
/* ================================================= */

function toggleFilters(){

 document
  .getElementById("filtersPanel")
  .classList.toggle("hidden");

}


function applyFilter(type,button){

 document
  .querySelectorAll(".filter")
  .forEach(function(x){

   x.classList.remove("active");

  });


 button.classList.add("active");


 const video =
  document.getElementById("cameraVideo");


 video.style.filter="none";


 if(type==="warm"){

  video.style.filter =
   "sepia(.35) saturate(1.5)";

 }


 if(type==="cool"){

  video.style.filter =
   "hue-rotate(150deg) saturate(1.3)";

 }


 if(type==="pink"){

  video.style.filter =
   "hue-rotate(290deg) saturate(1.5)";

 }


 if(type==="bw"){

  video.style.filter =
   "grayscale(1)";

 }


 if(type==="green"){

  video.style.filter =
   "hue-rotate(70deg) saturate(1.4)";

 }

}


/* التجميل */

function toggleBeauty(button){

 button.classList.toggle("selected");

 const video =
  document.getElementById("cameraVideo");


 if(button.classList.contains("selected")){

  video.style.filter =
   "brightness(1.08) saturate(1.12) contrast(.95)";

 }else{

  video.style.filter="none";

 }

}


/* ================================================= */
/*                اختيار المحتوى                     */
/* ================================================= */

function selectMode(mode,button){

 currentMode=mode;


 document
  .querySelectorAll(".createMode")
  .forEach(function(x){

   x.classList.remove("active");

  });


 button.classList.add("active");


 if(mode==="photo"){

  stopRecording();

  currentDuration=0;

  document
   .getElementById("durationBar")
   .classList.add("hidden");

  return;

 }


 if(mode==="text"){

  stopRecording();

  document
   .getElementById("durationBar")
   .classList.add("hidden");

  openTextCreator();

  return;

 }


 document
  .getElementById("durationBar")
  .classList.remove("hidden");


 if(mode==="video15"){

  setDuration(15);

 }


 if(mode==="video60"){

  setDuration(60);

 }


 if(mode==="video600"){

  setDuration(600);

 }

}


/* ================================================= */
/*                 مدة الفيديو                       */
/* ================================================= */

function setDuration(seconds,button){

 currentDuration=seconds;


 if(button){

  document
   .querySelectorAll(".duration")
   .forEach(function(x){

    x.classList.remove("active");

   });

  button.classList.add("active");

 }


 if(seconds===15){

  currentMode="video15";

 }


 if(seconds===60){

  currentMode="video60";

 }


 if(seconds===600){

  currentMode="video600";

 }

}


/* ================================================= */
/*                  التسجيل                         */
/* ================================================= */

function recordAction(){

 if(currentMode==="photo"){

  takePhoto();

  return;

 }


 if(currentMode==="text"){

  openTextCreator();

  return;

 }


 if(recording){

  stopRecording();

 }else{

  startRecording();

 }

}


/* بدء التسجيل */

function startRecording(){

 if(!cameraStream){

  toast("الكاميرا غير متاحة");

  return;

 }


 recordedChunks=[];


 let mimeType="";


 if(
  MediaRecorder.isTypeSupported &&
  MediaRecorder.isTypeSupported(
   "video/webm;codecs=vp9,opus"
  )
 ){

  mimeType =
   "video/webm;codecs=vp9,opus";

 }else if(
  MediaRecorder.isTypeSupported &&
  MediaRecorder.isTypeSupported(
   "video/webm;codecs=vp8,opus"
  )
 ){

  mimeType =
   "video/webm;codecs=vp8,opus";

 }else{

  mimeType="";

 }


 try{

  mediaRecorder =
   mimeType
   ?new MediaRecorder(
     cameraStream,
     {mimeType:mimeType}
    )
   :new MediaRecorder(
     cameraStream
    );

 }catch(error){

  toast(
   "الجهاز لا يدعم تسجيل الفيديو"
  );

  return;

 }


 mediaRecorder.ondataavailable =
  function(event){

   if(event.data &&
      event.data.size>0){

    recordedChunks.push(
     event.data
    );

   }

  };


 mediaRecorder.onstop =
  function(){

   if(!recordedChunks.length){

    toast("لم يتم تسجيل فيديو");

    return;

   }


   const type =
    mediaRecorder.mimeType ||
    "video/webm";


   const blob =
    new Blob(
     recordedChunks,
     {type:type}
    );


   const url =
    URL.createObjectURL(blob);


   showPreview(
    url,
    "video"
   );

  };


 mediaRecorder.onerror =
  function(){

   toast("حدث خطأ أثناء التسجيل");

  };


 mediaRecorder.start(250);

 recording=true;

 elapsed=0;


 document
  .getElementById("recordButton")
  .classList.add("recording");


 document
  .getElementById("recordTimer")
  .style.display="block";


 updateTimer();


 clearInterval(timerInterval);


 timerInterval =
  setInterval(
   updateTimer,
   1000
  );


 clearTimeout(recordingTimeout);


 recordingTimeout =
  setTimeout(
   function(){

    if(recording){

     stopRecording();

    }

   },
   currentDuration*1000
  );

}


/* إيقاف التسجيل */

function stopRecording(){

 if(!recording){

  return;

 }


 recording=false;


 clearInterval(timerInterval);

 clearTimeout(recordingTimeout);


 timerInterval=null;
 recordingTimeout=null;


 if(
  mediaRecorder &&
  mediaRecorder.state!=="inactive"
 ){

  mediaRecorder.stop();

 }


 document
  .getElementById("recordButton")
  .classList.remove("recording");


 document
  .getElementById("recordTimer")
  .style.display="none";

}


/* العداد */

function updateTimer(){

 if(!recording){

  return;

 }


 elapsed++;


 const minutes =
  Math.floor(
   elapsed/60
  );


 const seconds =
  elapsed%60;


 document
  .getElementById("recordTimer")
  .innerText =
   String(minutes)
    .padStart(2,"0")
   +":"
   +
   String(seconds)
    .padStart(2,"0");

}


/* ================================================= */
/*                    الصورة                         */
/* ================================================= */

function takePhoto(){

 if(!cameraStream){

  toast("الكاميرا غير متاحة");

  return;

 }


 const video =
  document.getElementById("cameraVideo");


 const canvas =
  document.createElement("canvas");


 canvas.width =
  video.videoWidth || 1080;


 canvas.height =
  video.videoHeight || 1920;


 const ctx =
  canvas.getContext("2d");


 if(currentFacing==="user"){

  ctx.translate(
   canvas.width,
   0
  );

  ctx.scale(
   -1,
   1
  );

 }


 ctx.drawImage(
  video,
  0,
  0,
  canvas.width,
  canvas.height
 );


 const url =
  canvas.toDataURL(
   "image/jpeg",
   .92
  );


 showPreview(
  url,
  "image"
 );

}


/* ================================================= */
/*                    المعرض                         */
/* ================================================= */

function openGallery(){

 document
  .getElementById("galleryInput")
  .click();

}


function gallerySelected(input){

 const file =
  input.files[0];


 if(!file){

  return;

 }


 const url =
  URL.createObjectURL(file);


 const type =
  file.type.startsWith("video")
  ?"video"
  :"image";


 showPreview(
  url,
  type
 );


 input.value="";

}


/* ================================================= */
/*                      النص                         */
/* ================================================= */

function openTextCreator(){

 document
  .getElementById("textCreator")
  .classList.add("active");


 setTimeout(function(){

  document
   .getElementById("textInput")
   .focus();

 },100);

}


function closeTextCreator(){

 document
  .getElementById("textCreator")
  .classList.remove("active");

}


function finishText(){

 const text =
  document
   .getElementById("textInput")
   .value
   .trim();


 if(!text){

  toast("اكتب النص أولاً");

  return;

 }


 const canvas =
  document.createElement("canvas");


 canvas.width=1080;
 canvas.height=1920;


 const ctx =
  canvas.getContext("2d");


 const gradient =
  ctx.createLinearGradient(
   0,
   0,
   1080,
   1920
  );


 gradient.addColorStop(
  0,
  "#ff0050"
 );


 gradient.addColorStop(
  1,
  "#5500ff"
 );


 ctx.fillStyle=gradient;


 ctx.fillRect(
  0,
  0,
  canvas.width,
  canvas.height
 );


 ctx.fillStyle="#fff";

 ctx.textAlign="center";

 ctx.textBaseline="middle";

 ctx.font=
  "bold 65px Arial";


 const words =
  text.split(" ");


 const lines=[];

 let line="";


 words.forEach(function(word){

  const test =
   line
   ?line+" "+word
   :word;


  if(
   ctx.measureText(test).width
   >850
  ){

   if(line){

    lines.push(line);

   }

   line=word;

  }else{

   line=test;

  }

 });


 if(line){

  lines.push(line);

 }


 const startY =
  canvas.height/2
  -
  ((lines.length-1)*45);


 lines.forEach(
  function(line,i){

   ctx.fillText(
    line,
    canvas.width/2,
    startY+i*90
   );

  }
 );


 const url =
  canvas.toDataURL(
   "image/png"
  );


 closeTextCreator();


 showPreview(
  url,
  "image"
 );

}


/* ================================================= */
/*                    المعاينة                       */
/* ================================================= */

function showPreview(url,type){

 document
  .getElementById("previewScreen")
  .classList.add("active");


 const box =
  document.getElementById("previewMedia");


 box.innerHTML="";


 if(type==="video"){

  const video =
   document.createElement("video");


  video.src=url;

  video.controls=true;

  video.autoplay=true;

  video.loop=true;

  video.playsInline=true;


  box.appendChild(video);

 }else{

  const img =
   document.createElement("img");


  img.src=url;


  box.appendChild(img);

 }

}


function closePreview(){

 document
  .getElementById("previewScreen")
  .classList.remove("active");


 document
  .getElementById("previewMedia")
  .innerHTML="";

}


function publishContent(){

 toast(
  "تم تجهيز المحتوى للنشر ✓"
 );


 setTimeout(
  function(){

   closePreview();

  },
  800
 );

}


/* ================================================= */
/*                    الحساب                         */
/* ================================================= */

function profileAction(){

 if(account){

  openEdit();

 }else{

  openLogin();

 }

}


function updateProfile(){

 if(!account){

  document
   .getElementById("profileName")
   .innerText="زائر";


  document
   .getElementById("profileUsername")
   .innerText=
    "لم تسجل الدخول";


  document
   .getElementById("profileBio")
   .innerText="";


  document
   .getElementById("profileAvatar")
   .innerHTML="👤";


  document
   .getElementById("profileButton")
   .innerText=
    "تسجيل الدخول";


  document
   .getElementById("socials")
   .innerHTML="";


  return;

 }


 document
  .getElementById("profileName")
  .innerText =
   account.name ||
   "مستخدم فيديوز";


 document
  .getElementById("profileUsername")
  .innerText =
   "@"+
   (
    account.username ||
    "videoz"
   );


 document
  .getElementById("profileBio")
  .innerText =
   account.bio ||
   "";


 if(account.photo){

  document
   .getElementById("profileAvatar")
   .innerHTML =
    "<img src='"+account.photo+"'>";

 }else{

  document
   .getElementById("profileAvatar")
   .innerHTML="👤";

 }


 document
  .getElementById("profileButton")
  .innerText=
   "تعديل الحساب";


 showSocials();

}


function showSocials(){

 const box =
  document.getElementById("socials");


 box.innerHTML="";


 const links=[
  ["youtube","🔴 YouTube"],
  ["instagram","📸 Instagram"],
  ["telegram","✈️ Telegram"],
  ["facebook","🔵 Facebook"],
  ["tiktok","🎵 TikTok"],
  ["website","🔗 رابط"]
 ];


 links.forEach(
  function(item){

   const key =
    item[0];


   if(
    account &&
    account[key]
   ){

    const a =
     document.createElement("a");


    a.className="social";

    a.target="_blank";

    a.rel="noopener";


    a.href =
     account[key]
      .startsWith("http")
      ?account[key]
      :"https://"+account[key];


    a.innerText =
     item[1];


    box.appendChild(a);

   }

  }
 );

}


/* ================================================= */
/*                 تسجيل الدخول                      */
/* ================================================= */

function openLogin(){

 document
  .getElementById("loginModal")
  .classList.remove("hidden");

}


function closeLogin(){

 document
  .getElementById("loginModal")
  .classList.add("hidden");


 document
  .getElementById("formModal")
  .classList.add("hidden");

}


function showLoginForm(type){

 document
  .getElementById("loginModal")
  .classList.add("hidden");


 document
  .getElementById("formModal")
  .classList.remove("hidden");


 const title =
  document.getElementById("formTitle");


 const icon =
  document.getElementById("formIcon");


 const email =
  document.getElementById("loginEmail");


 if(type==="phone"){

  title.innerText =
   "تسجيل الدخول برقم الهاتف";

  icon.innerText="📱";

  email.placeholder=
   "رقم الهاتف";

 }


 if(type==="google"){

  title.innerText =
   "تسجيل الدخول باستخدام Google";

  icon.innerText="G";

  email.placeholder=
   "البريد الإلكتروني";

 }


 if(type==="facebook"){

  title.innerText =
   "تسجيل الدخول باستخدام Facebook";

  icon.innerText="f";

  email.placeholder=
   "البريد الإلكتروني أو رقم الهاتف";

 }


 window.loginType=type;

}


function backToLoginMethods(){

 document
  .getElementById("formModal")
  .classList.add("hidden");


 openLogin();

}


function performLogin(){

 const value =
  document
   .getElementById("loginEmail")
   .value
   .trim();


 const password =
  document
   .getElementById("loginPassword")
   .value
   .trim();


 if(!value){

  toast(
   "أدخل بيانات تسجيل الدخول"
  );

  return;

 }


 if(!password){

  toast(
   "أدخل كلمة المرور"
  );

  return;

 }


 account={

  name:
   value.includes("@")
   ?value.split("@")[0]
   :"مستخدم فيديوز",

  username:
   value.includes("@")
   ?value.split("@")[0]
   :"videoz_user",

  bio:"",
  photo:"",

  youtube:"",
  instagram:"",
  telegram:"",
  facebook:"",
  tiktok:"",
  website:""

 };


 localStorage.setItem(
  "videozAccount",
  JSON.stringify(account)
 );


 closeLogin();


 updateProfile();


 toast(
  "تم تسجيل الدخول بنجاح ✓"
 );

}


/* ================================================= */
/*                 تعديل الحساب                     */
/* ================================================= */

function openEdit(){

 if(!account){

  openLogin();

  return;

 }


 document
  .getElementById("editModal")
  .classList.remove("hidden");


 document
  .getElementById("editName")
  .value =
   account.name || "";


 document
  .getElementById("editUsername")
  .value =
   account.username || "";


 document
  .getElementById("editBio")
  .value =
   account.bio || "";


 document
  .getElementById("youtube")
  .value =
   account.youtube || "";


 document
  .getElementById("instagram")
  .value =
   account.instagram || "";


 document
  .getElementById("telegram")
  .value =
   account.telegram || "";


 document
  .getElementById("facebook")
  .value =
   account.facebook || "";


 document
  .getElementById("tiktok")
  .value =
   account.tiktok || "";


 document
  .getElementById("website")
  .value =
   account.website || "";


 const avatar =
  document.getElementById("editAvatar");


 if(account.photo){

  avatar.innerHTML =
   "<img src='"+account.photo+"'>";

 }else{

  avatar.innerHTML="👤";

 }

}


function closeEdit(){

 document
  .getElementById("editModal")
  .classList.add("hidden");

}


function changePhoto(input){

 const file =
  input.files[0];


 if(!file){

  return;

 }


 const reader =
  new FileReader();


 reader.onload =
  function(e){

   account.photo =
    e.target.result;


   document
    .getElementById("editAvatar")
    .innerHTML =
     "<img src='"+account.photo+"'>";

  };


 reader.readAsDataURL(file);

}


function saveProfile(){

 account.name =
  document
   .getElementById("editName")
   .value
   .trim()
   ||
  "مستخدم فيديوز";


 account.username =
  document
   .getElementById("editUsername")
   .value
   .trim()
   .replace(/^@/,"")
   ||
  "videoz_user";


 account.bio =
  document
   .getElementById("editBio")
   .value
   .trim();


 account.youtube =
  document
   .getElementById("youtube")
   .value
   .trim();


 account.instagram =
  document
   .getElementById("instagram")
   .value
   .trim();


 account.telegram =
  document
   .getElementById("telegram")
   .value
   .trim();


 account.facebook =
  document
   .getElementById("facebook")
   .value
   .trim();


 account.tiktok =
  document
   .getElementById("tiktok")
   .value
   .trim();


 account.website =
  document
   .getElementById("website")
   .value
   .trim();


 localStorage.setItem(
  "videozAccount",
  JSON.stringify(account)
 );


 updateProfile();


 closeEdit();


 toast(
  "تم حفظ تعديلات الحساب ✓"
 );

}


/* ================================================= */
/*                    المميزات                       */
/* ================================================= */

function like(button){

 if(!account){

  openLogin();

  toast(
   "سجل الدخول أولاً"
  );

  return;

 }


 button.classList.toggle(
  "liked"
 );

}


function saveVideo(button){

 if(!account){

  openLogin();

  return;

 }


 button
  .querySelector(".actionIcon")
  .innerText="✅";

}


function comment(){

 if(!account){

  openLogin();

  toast(
   "سجل الدخول أولاً للتعليق"
  );

  return;

 }


 toast(
  "تم فتح التعليقات"
 );

}


async function shareVideo(){

 if(
  navigator.share
 ){

  try{

   await navigator.share({

    title:"فيديوز",

    text:
     "شاهد هذا الفيديو على فيديوز"

   });

  }catch(e){

   console.log(e);

  }

 }else{

  toast(
   "المشاركة غير متاحة في هذا المتصفح"
  );

 }

}


/* ================================================= */
/*                      Toast                        */
/* ================================================= */

function toast(message){

 const old =
  document.querySelector(".toast");


 if(old){

  old.remove();

 }


 const box =
  document.createElement("div");


 box.className="toast";


 box.innerText=message;


 document.body.appendChild(box);


 setTimeout(
  function(){

   if(box.parentNode){

    box.remove();

   }

  },
  2500
 );

}


/* ================================================= */
/*                  تشغيل الحساب                     */
/* ================================================= */

updateProfile();

</script>

</body>
</html>