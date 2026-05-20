<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="apple-mobile-web-app-title" content="COLE OS">
<meta name="mobile-web-app-capable" content="yes">
<meta name="theme-color" content="#0c0c0e">
<title>COLE</title>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:wght@300;400;500;600&family=DM+Mono:wght@300;400&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{height:100%;overflow:hidden}
body{height:100%;overflow:hidden;font-family:'DM Sans',sans-serif;background:var(--bg);color:var(--text);transition:background .3s,color .3s}
:root{--bg:#0c0c0e;--card:#141418;--card2:#1a1a20;--accent:#d4a843;--accent-l:#e8c97a;--text:#f0ead8;--muted:#6b5f4a;--muted2:#2a2418;--red:#e05252;--green:#5cb85c;--blue:#5b9bd5;--border:#2a2418;--pink:#d4a843}
body.theme-light{--bg:#f5f0ea;--card:#fff;--card2:#f0ebe3;--accent:#c2185b;--accent-l:#e91e8c;--text:#1a1a1a;--muted:#6b6b6b;--muted2:#d4ccc5;--red:#c62828;--green:#2e7d32;--blue:#1565c0;--border:#e8e0d8;--pink:#c2185b}
body.theme-dark{--bg:#000;--card:#111;--card2:#1a1a1a;--accent:#e0e0e0;--accent-l:#fff;--text:#fff;--muted:#666;--muted2:#222;--red:#ff5555;--green:#55ee88;--blue:#66aaff;--border:#222;--pink:#e0e0e0}
body.theme-chatgpt{--bg:#0d0e12;--card:#161b27;--card2:#1e2535;--accent:#7c6aff;--accent-l:#9d8fff;--text:#e8e8f0;--muted:#6b7280;--muted2:#2d3548;--red:#f87171;--green:#4ade80;--blue:#60a5fa;--border:#252d3d;--pink:#7c6aff}
body.fs-sm{font-size:12px}body.fs-md{font-size:14px}body.fs-lg{font-size:16px}body.fs-xl{font-size:18px}
#splash{position:fixed;inset:0;background:#000;display:flex;align-items:center;justify-content:center;z-index:9000;transition:opacity .6s}
#splash.hide{opacity:0;pointer-events:none}
.splash-inner{text-align:center}
.splash-c{font-family:'Bebas Neue',sans-serif;font-size:100px;color:#d4a843;animation:sIn 1.4s ease;letter-spacing:8px;line-height:1}
.splash-sub{font-family:'DM Mono',monospace;font-size:10px;color:#6b5f4a;letter-spacing:6px;margin-top:6px;animation:sIn 1.4s ease .2s both;text-transform:uppercase}
@keyframes sIn{0%{opacity:0;transform:scale(.6)}60%{opacity:1;transform:scale(1.05)}100%{opacity:1;transform:scale(1)}}
#notif-bar{position:fixed;top:0;left:0;right:0;z-index:8000;pointer-events:none;display:flex;flex-direction:column}
.ntitem{background:var(--card);border-bottom:2px solid var(--accent);padding:10px 14px;display:flex;align-items:center;gap:10px;pointer-events:all;animation:ntSlide .3s ease;box-shadow:0 4px 20px rgba(0,0,0,.3)}
@keyframes ntSlide{from{transform:translateY(-100%);opacity:0}to{transform:translateY(0);opacity:1}}
.ntdot{width:6px;height:6px;border-radius:50%;flex-shrink:0}
.nttxt{flex:1;font-size:12px;font-weight:600;color:var(--text)}
.ntclose{font-size:16px;color:var(--muted);cursor:pointer;line-height:1;padding:0 4px;flex-shrink:0}
#save-indicator{position:fixed;top:10px;right:14px;z-index:8500;background:var(--green);color:#fff;font-family:'DM Mono',monospace;font-size:9px;font-weight:700;letter-spacing:2px;padding:4px 10px;border-radius:20px;opacity:0;transition:opacity .3s;pointer-events:none}
#save-indicator.show{opacity:1}
#homepage,.cat-overlay,.sec-page{position:fixed;top:0;left:0;right:0;bottom:0;background:var(--bg);display:flex;flex-direction:column;overflow:hidden}
#homepage{z-index:10}
.cat-overlay{z-index:100;transform:translateX(100%);transition:transform .28s cubic-bezier(.4,0,.2,1);pointer-events:none}
.cat-overlay.open{transform:translateX(0);pointer-events:all}
.sec-page{z-index:200;transform:translateX(100%);transition:transform .28s cubic-bezier(.4,0,.2,1);pointer-events:none}
.sec-page.open{transform:translateX(0);pointer-events:all}
.scroll-body{flex:1;overflow-y:auto;-webkit-overflow-scrolling:touch;padding-bottom:40px}
#menu-overlay{position:fixed;inset:0;background:rgba(0,0,0,.7);z-index:500;display:none}
#menu-overlay.open{display:block}
#menu-drawer{position:fixed;left:0;top:0;bottom:0;width:72%;max-width:270px;background:var(--card);z-index:600;display:flex;flex-direction:column;transform:translateX(-100%);transition:transform .28s ease;overflow-y:auto;border-right:1px solid var(--border)}
#menu-drawer.open{transform:translateX(0)}
.md-header{padding:54px 20px 18px;border-bottom:1px solid var(--border)}
.md-logo{font-family:'Bebas Neue',sans-serif;font-size:32px;letter-spacing:6px;color:var(--accent);line-height:1}
.md-sub{font-size:9px;color:var(--muted);font-family:'DM Mono',monospace;letter-spacing:2px;margin-top:3px;text-transform:uppercase}
.md-sect{font-size:9px;color:var(--muted);letter-spacing:2px;font-family:'DM Mono',monospace;font-weight:600;padding:14px 20px 5px;text-transform:uppercase;opacity:.6}
.md-item{display:flex;align-items:center;gap:12px;padding:14px 20px;cursor:pointer;border-bottom:1px solid var(--border);transition:background .15s}
.md-item:active{background:var(--card2)}
.md-icon{width:34px;height:34px;border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0}
.md-label{font-size:14px;font-weight:500;color:var(--text)}
.md-chevron{margin-left:auto;color:var(--muted);font-size:16px}
.pg-header{display:flex;align-items:center;gap:12px;padding:52px 18px 14px;border-bottom:1px solid var(--border);flex-shrink:0}
.pg-back{background:none;border:none;color:var(--text);font-size:28px;cursor:pointer;line-height:1;padding:0;flex-shrink:0;opacity:.7}
.pg-title{font-family:'Bebas Neue',sans-serif;font-size:22px;letter-spacing:3px;color:var(--text)}
.home-topbar{display:flex;align-items:center;gap:10px;padding:52px 16px 12px;flex-shrink:0}
.menu-btn{width:40px;height:40px;min-width:40px;background:var(--card);border:1px solid var(--border);border-radius:12px;display:flex;align-items:center;justify-content:center;cursor:pointer;flex-shrink:0}
.search-wrap{flex:1;min-width:0;position:relative}
.search-inp{width:100%;background:var(--card);border:1.5px solid var(--border);border-radius:12px;padding:10px 12px 10px 36px;font-size:13px;color:var(--text);outline:none;font-family:'DM Sans',sans-serif;transition:border-color .2s}
.search-inp:focus{border-color:var(--accent)}
.s-icon{position:absolute;left:11px;top:50%;transform:translateY(-50%);color:var(--muted);pointer-events:none}
#search-results{position:absolute;top:calc(100% + 5px);left:0;right:0;background:var(--card);border:1.5px solid var(--border);border-radius:14px;z-index:700;display:none;max-height:300px;overflow-y:auto;box-shadow:0 12px 40px rgba(0,0,0,.4)}
.home-greet-area{padding:4px 18px 16px;flex-shrink:0}
.home-greeting{font-family:'Bebas Neue',sans-serif;font-size:30px;letter-spacing:3px;color:var(--accent);line-height:1.1}
.home-tagline{font-size:11px;color:var(--muted);font-family:'DM Mono',monospace;margin-top:3px;letter-spacing:.5px}
.home-date-badge{display:inline-flex;align-items:center;gap:6px;margin-top:8px;background:var(--card);border:1px solid var(--border);border-radius:8px;padding:6px 10px}
.home-date-txt{font-size:10px;color:var(--muted);font-family:'DM Mono',monospace;font-weight:600;letter-spacing:1px}
.home-stats{display:grid;grid-template-columns:1fr 1fr;gap:8px;padding:0 16px 12px;flex-shrink:0}
.hstat{background:var(--card);border:1px solid var(--border);border-radius:13px;padding:12px 14px;position:relative;overflow:hidden}
.hstat::before{content:'';position:absolute;top:0;right:0;width:3px;height:100%;background:var(--accent);opacity:.4;border-radius:0 13px 13px 0}
.hstat-lbl{font-size:8px;color:var(--muted);font-family:'DM Mono',monospace;letter-spacing:1.5px;text-transform:uppercase;margin-bottom:5px;font-weight:600}
.hstat-val{font-size:17px;font-weight:700;font-family:'DM Mono',monospace}
.home-cats{display:grid;grid-template-columns:repeat(3,1fr);gap:8px;padding:0 16px 12px;flex-shrink:0}
.home-cat{background:var(--card);border:1px solid var(--border);border-radius:14px;padding:14px 8px;text-align:center;cursor:pointer;transition:all .15s;min-width:0;position:relative}
.home-cat:active{transform:scale(.96);background:var(--card2)}
.hc-icon{width:38px;height:38px;border-radius:11px;margin:0 auto 8px;display:flex;align-items:center;justify-content:center}
.hc-label{font-family:'Bebas Neue',sans-serif;font-size:13px;letter-spacing:1.5px;color:var(--text)}
.hc-sub{font-size:9px;color:var(--muted);font-family:'DM Mono',monospace;margin-top:2px}
.quote-card{margin:0 16px 16px;background:linear-gradient(135deg,var(--card) 0%,var(--card2) 100%);border-radius:16px;padding:18px 16px;border:1px solid var(--border);position:relative;overflow:hidden;flex-shrink:0}
.quote-card::before{content:'';position:absolute;top:-20px;right:-20px;width:80px;height:80px;background:var(--accent);opacity:.06;border-radius:50%}
.quote-icon{font-size:20px;color:var(--accent);opacity:.7;margin-bottom:8px;font-family:'Georgia',serif;line-height:1}
.quote-txt{font-size:13px;color:var(--text);line-height:1.6;font-style:italic;font-weight:400;position:relative;z-index:1}
.quote-attr{font-size:9px;color:var(--muted);font-family:'DM Mono',monospace;margin-top:8px;letter-spacing:1px;text-transform:uppercase;position:relative;z-index:1}
.quote-refresh{position:absolute;top:12px;right:12px;background:none;border:1px solid var(--border);border-radius:7px;padding:5px 8px;font-size:11px;cursor:pointer;color:var(--muted);font-family:'DM Mono',monospace;z-index:1;transition:all .2s}
.quote-refresh:active{background:var(--card2);color:var(--accent)}
.quote-fade{animation:quoteFade .5s ease}
@keyframes quoteFade{0%{opacity:0;transform:translateY(6px)}100%{opacity:1;transform:translateY(0)}}
.cat-list-item{display:flex;align-items:center;gap:14px;padding:15px 18px;border-bottom:1px solid var(--border);cursor:pointer;transition:background .15s}
.cat-list-item:active{background:var(--card2)}
.cli-icon{width:40px;height:40px;border-radius:12px;display:flex;align-items:center;justify-content:center;flex-shrink:0}
.cli-name{font-size:14px;font-weight:600;color:var(--text)}
.cli-desc{font-size:11px;color:var(--muted);margin-top:2px}
.cli-arrow{color:var(--muted);font-size:18px;margin-left:auto}
.card{background:var(--card);border-radius:14px;padding:16px;margin:0 16px 12px;border:1px solid var(--border)}
.ct{font-size:9px;letter-spacing:2px;color:var(--muted);text-transform:uppercase;margin-bottom:12px;font-family:'DM Mono',monospace;font-weight:600}
.sl{font-size:9px;letter-spacing:2px;color:var(--muted);text-transform:uppercase;padding:4px 18px 10px;font-family:'DM Mono',monospace;font-weight:600}
input,textarea,select{background:var(--card2);border:1.5px solid var(--border);border-radius:8px;color:var(--text);font-family:'DM Sans',sans-serif;font-size:12px;padding:10px 12px;outline:none;width:100%;transition:border-color .2s}
input:focus,textarea:focus,select:focus{border-color:var(--accent)}
::placeholder{color:var(--muted)}
select option{background:var(--card)}
.btn-pk{width:100%;background:var(--accent);border:none;border-radius:10px;color:#000;font-weight:700;font-size:13px;padding:12px;cursor:pointer;font-family:'DM Sans',sans-serif;margin-top:2px;transition:opacity .2s;letter-spacing:.5px}
.btn-pk:active{opacity:.8}
.btn-gh{background:none;border:1.5px solid var(--border);border-radius:8px;color:var(--text);font-size:10px;padding:7px 13px;cursor:pointer;font-family:'DM Sans',sans-serif}
.r2{display:flex;gap:8px}.r2>*{flex:1;margin-bottom:0}
.empty-state{text-align:center;padding:24px;color:var(--muted);font-size:12px;font-style:italic}
.add-bar{background:var(--card);border-bottom:1px solid var(--border);padding:10px 14px;flex-shrink:0}
.add-row{display:flex;gap:8px;margin-bottom:6px}
.add-inp{flex:1;margin-bottom:0}
.add-btn{background:var(--accent);border:none;border-radius:8px;color:#000;font-weight:700;font-size:20px;padding:8px 16px;cursor:pointer;flex-shrink:0;transition:opacity .2s}
.add-extra{display:flex;gap:6px;margin-bottom:6px}.add-extra>*{flex:1;font-size:10px;padding:7px 9px;margin-bottom:0}
.add-extra2{display:flex;gap:6px}.add-extra2>*{flex:1;font-size:10px;padding:7px 9px;margin-bottom:0}
.task-hdr{display:flex;align-items:center;justify-content:space-between;padding:14px 18px 10px;flex-shrink:0}
.task-title{font-family:'Bebas Neue',sans-serif;font-size:24px;letter-spacing:3px;color:var(--text)}
.task-cnt{font-size:12px;color:var(--muted);font-family:'DM Mono',monospace}
.prog-wrap{padding:0 18px 10px;flex-shrink:0}
.prog-bg{background:var(--border);height:4px;border-radius:4px;overflow:hidden}
.prog-fill{height:100%;background:var(--accent);border-radius:4px;transition:width .5s cubic-bezier(.4,0,.2,1)}
.prog-meta{display:flex;justify-content:space-between;margin-top:5px;font-size:10px;color:var(--muted);font-family:'DM Mono',monospace}
.filter-row{display:flex;gap:6px;padding:0 14px 10px;overflow-x:auto;scrollbar-width:none;flex-shrink:0}
.filter-row::-webkit-scrollbar{display:none}
.chip{background:var(--card);border:1.5px solid var(--border);color:var(--muted);border-radius:20px;padding:5px 13px;font-size:10px;white-space:nowrap;cursor:pointer;font-family:'DM Mono',monospace;font-weight:600;text-transform:uppercase;transition:all .15s}
.chip.active{background:var(--accent);color:#000;border-color:var(--accent)}
.tgl{font-size:9px;letter-spacing:2px;color:var(--muted);padding:10px 18px 5px;text-transform:uppercase;font-family:'DM Mono',monospace;font-weight:600}
.trow{display:flex;align-items:flex-start;gap:10px;padding:12px 18px;border-bottom:1px solid var(--border)}
.tck{width:21px;height:21px;border:2px solid var(--muted2);border-radius:6px;flex-shrink:0;display:flex;align-items:center;justify-content:center;cursor:pointer;margin-top:2px;transition:all .15s}
.tck.done{background:var(--accent);border-color:var(--accent)}
.tck.done::after{content:"✓";font-size:11px;color:#000;font-weight:700}
.tb{flex:1;min-width:0}
.tt{font-size:14px;cursor:pointer;line-height:1.4;color:var(--text);font-weight:500}
.tt.done{text-decoration:line-through;color:var(--muted);font-weight:400}
.tt.urg{color:var(--red);font-weight:600}
.tmeta{display:flex;align-items:center;gap:7px;margin-top:4px;flex-wrap:wrap}
.tamt{font-size:10px;font-family:'DM Mono',monospace;font-weight:600}
.tamt.in{color:var(--green)}.tamt.out{color:var(--red)}
.tdaytime{font-size:10px;color:var(--muted);font-family:'DM Mono',monospace}
.rdot{width:7px;height:7px;border-radius:50%;background:var(--red);flex-shrink:0;margin-top:5px}
.task-actions{display:flex;align-items:center;gap:4px;flex-shrink:0}
.task-action-btn{background:none;border:none;font-size:15px;cursor:pointer;padding:3px 5px;color:var(--muted);line-height:1;border-radius:5px;transition:all .15s}
.task-action-btn:active{background:var(--card2);color:var(--text)}
.edit-modal-overlay{position:fixed;inset:0;background:rgba(0,0,0,.7);z-index:2000;display:none;align-items:flex-end}
.edit-modal-overlay.open{display:flex;animation:fadeIn .2s ease}
@keyframes fadeIn{from{opacity:0}to{opacity:1}}
.edit-modal{background:var(--card);border-radius:20px 20px 0 0;padding:20px 18px 40px;width:100%;max-height:85vh;overflow-y:auto;animation:slideUp .28s cubic-bezier(.4,0,.2,1)}
@keyframes slideUp{from{transform:translateY(100%)}to{transform:translateY(0)}}
.edit-modal-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:18px}
.edit-modal-title{font-family:'Bebas Neue',sans-serif;font-size:20px;letter-spacing:2px;color:var(--text)}
.edit-modal-close{background:none;border:1.5px solid var(--border);border-radius:8px;padding:6px 12px;color:var(--muted);font-size:12px;cursor:pointer;font-family:'DM Sans',sans-serif}
.edit-modal-field{margin-bottom:12px}
.edit-modal-label{font-size:9px;color:var(--muted);font-family:'DM Mono',monospace;letter-spacing:1.5px;text-transform:uppercase;font-weight:600;margin-bottom:5px}
.edit-modal-save{width:100%;background:var(--accent);border:none;border-radius:10px;color:#000;font-weight:700;font-size:14px;padding:14px;cursor:pointer;font-family:'DM Sans',sans-serif;margin-top:6px;letter-spacing:.5px}
.bal-hero{background:linear-gradient(135deg,var(--accent) 0%,var(--accent-l) 100%);border-radius:16px;padding:20px;margin:0 16px 12px;text-align:center;position:relative;overflow:hidden}
.bal-hero::before{content:'';position:absolute;top:-30px;right:-30px;width:100px;height:100px;background:rgba(255,255,255,.1);border-radius:50%}
.bal-lbl{font-size:9px;letter-spacing:3px;color:rgba(0,0,0,.6);text-transform:uppercase;font-family:'DM Mono',monospace;margin-bottom:6px;font-weight:600}
.bal-val{font-size:34px;font-weight:700;font-family:'DM Mono',monospace;color:#000;position:relative;z-index:1}
.bal-sub{font-size:10px;color:rgba(0,0,0,.5);margin-top:4px;font-family:'DM Mono',monospace;position:relative;z-index:1}
.fin-grid{display:grid;grid-template-columns:1fr 1fr;gap:8px;margin:0 16px 12px}
.fin-card{background:var(--card);border-radius:12px;padding:12px;border:1px solid var(--border)}
.fin-lbl{font-size:8px;letter-spacing:1.5px;text-transform:uppercase;font-family:'DM Mono',monospace;margin-bottom:4px;font-weight:600}
.fin-val{font-size:15px;font-weight:700;font-family:'DM Mono',monospace}
.fin-sub{font-size:8px;color:var(--muted);margin-top:2px;font-family:'DM Mono',monospace}
.tov{background:var(--card);border-radius:14px;padding:14px;margin:0 16px 12px;border:1px solid var(--border)}
.tovi{display:flex;gap:14px;align-items:center}
.dw{position:relative;width:88px;height:88px;flex-shrink:0}.dw svg{transform:rotate(-90deg)}
.dc{position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);text-align:center}
.dn{font-size:20px;font-weight:700;font-family:'DM Mono',monospace;line-height:1;color:var(--text)}.dl{font-size:8px;color:var(--muted)}
.leg{flex:1;display:flex;flex-direction:column;gap:7px}
.li{display:flex;align-items:center;gap:7px;font-size:12px;color:var(--text)}
.ld{width:7px;height:7px;border-radius:50%;flex-shrink:0}
.txr{display:flex;align-items:center;gap:10px;padding:10px 0;border-bottom:1px solid var(--border)}.txr:last-child{border-bottom:none}
.tx-ico{width:30px;height:30px;border-radius:9px;display:flex;align-items:center;justify-content:center;font-size:9px;flex-shrink:0;font-family:'DM Mono',monospace;font-weight:700}
.tx-ico.in{background:rgba(92,184,92,.12);color:var(--green)}.tx-ico.out{background:rgba(224,82,82,.12);color:var(--red)}
.tx-name{font-size:12px;font-weight:600;color:var(--text)}.tx-tag{font-size:8px;color:var(--muted);margin-top:2px;font-family:'DM Mono',monospace}
.tx-amt{font-size:12px;font-weight:700;font-family:'DM Mono',monospace}
.tx-amt.in{color:var(--green)}.tx-amt.out{color:var(--red)}
.msum{display:grid;grid-template-columns:1fr 1fr 1fr;gap:8px;padding:0 16px 12px}
.msc{background:var(--card);border-radius:11px;padding:11px;border:1px solid var(--border)}
.msl{font-size:8px;color:var(--muted);letter-spacing:1px;text-transform:uppercase;margin-bottom:4px;font-family:'DM Mono',monospace;font-weight:600}
.msv{font-size:13px;font-weight:700;font-family:'DM Mono',monospace}
.sbal-card{background:var(--card);border-radius:14px;padding:14px;margin:0 16px 12px;border:2px solid var(--border)}
.sbal-lbl{font-size:9px;letter-spacing:2px;color:var(--muted);text-transform:uppercase;font-family:'DM Mono',monospace;margin-bottom:9px;font-weight:600}
.sbal-row{display:flex;gap:7px;align-items:center}
.sbal-inp{flex:1;font-size:15px;font-weight:700;font-family:'DM Mono',monospace;color:var(--green);margin:0}
.sbal-btn{background:var(--accent);border:none;border-radius:8px;color:#000;font-weight:700;font-size:12px;padding:10px 14px;cursor:pointer;white-space:nowrap}
.payi{display:flex;align-items:center;gap:10px;padding:11px 0;border-bottom:1px solid var(--border)}.payi:last-child{border-bottom:none}
.payico{width:32px;height:32px;border-radius:9px;display:flex;align-items:center;justify-content:center;font-size:9px;flex-shrink:0;font-family:'DM Mono',monospace;font-weight:700}
.payn{font-size:12px;font-weight:600;color:var(--text)}.payd{font-size:10px;color:var(--muted);margin-top:2px}
.paya{font-size:12px;font-weight:700;font-family:'DM Mono',monospace}
.paya.in{color:var(--green)}.paya.out{color:var(--red)}
.pb{font-size:8px;border-radius:4px;padding:2px 6px;margin-top:2px;display:inline-block;font-family:'DM Mono',monospace;font-weight:600}
.pb-g{background:rgba(92,184,92,.12);color:var(--green)}.pb-r{background:rgba(224,82,82,.12);color:var(--red)}
.loan-row{display:flex;align-items:center;gap:9px;padding:12px 0;border-bottom:1px solid var(--border)}.loan-row:last-child{border-bottom:none}
.loan-clear-btn{width:24px;height:24px;border-radius:50%;border:2px solid var(--muted2);background:none;cursor:pointer;display:flex;align-items:center;justify-content:center;flex-shrink:0;transition:all .2s}
.loan-clear-btn:active{background:var(--green);border-color:var(--green)}
.loan-name{font-size:14px;flex:1;color:var(--text);font-weight:500}
.loan-amt{font-size:12px;font-weight:700;font-family:'DM Mono',monospace}
.loan-when{font-size:8px;color:var(--muted);font-family:'DM Mono',monospace;margin-top:2px}
.ana-grid{display:grid;grid-template-columns:1fr 1fr;gap:8px;padding:0 16px;margin-bottom:12px}
.ana-card{background:var(--card);border-radius:11px;padding:12px;border:1px solid var(--border)}
.ana-lbl{font-size:8px;letter-spacing:1.5px;text-transform:uppercase;font-family:'DM Mono',monospace;margin-bottom:4px;font-weight:600;color:var(--muted)}
.ana-val{font-size:17px;font-weight:700;font-family:'DM Mono',monospace;color:var(--text)}
.ana-sub{font-size:9px;color:var(--muted);margin-top:2px;font-family:'DM Mono',monospace}
.trend-up{color:var(--green)}.trend-down{color:var(--red)}
.filter-bar{background:var(--card);border-bottom:1px solid var(--border);padding:9px 14px;flex-shrink:0}
.frow{display:flex;gap:5px;overflow-x:auto;scrollbar-width:none;margin-bottom:7px}
.frow::-webkit-scrollbar{display:none}
.fchip{padding:5px 11px;border-radius:20px;border:1.5px solid var(--border);background:var(--card2);color:var(--muted);font-size:10px;cursor:pointer;white-space:nowrap;font-family:'DM Mono',monospace;font-weight:600;text-transform:uppercase;flex-shrink:0;transition:all .15s}
.fchip.on{background:var(--accent);color:#000;border-color:var(--accent)}
.fdate-row{display:flex;gap:5px;align-items:center}
.fdate-row input{flex:1;padding:6px 9px;font-size:11px;margin-bottom:0}
.fapply{background:var(--accent);border:none;border-radius:7px;color:#000;font-weight:700;font-size:11px;padding:7px 12px;cursor:pointer;white-space:nowrap;flex-shrink:0}
.chart-card{background:var(--card);border-radius:12px;padding:13px;margin:0 16px 12px;border:1px solid var(--border)}
.insight-card{background:linear-gradient(135deg,rgba(212,168,67,.06),rgba(212,168,67,.02));border:1px solid rgba(212,168,67,.15);border-radius:12px;padding:12px;margin:0 16px 10px}
.insight-item{font-size:12px;color:var(--text);padding:5px 0;border-bottom:1px solid var(--border);line-height:1.5}
.insight-item:last-child{border-bottom:none}
.insight-icon{margin-right:6px}
.cal-nav{display:flex;align-items:center;justify-content:space-between;padding:12px 18px 8px;flex-shrink:0}
.cal-nav-btn{background:none;border:1.5px solid var(--border);border-radius:8px;padding:6px 12px;cursor:pointer;font-size:14px;color:var(--text)}
.cal-month{font-family:'Bebas Neue',sans-serif;font-size:20px;letter-spacing:3px;color:var(--text)}
.cal-grid7{display:grid;grid-template-columns:repeat(7,1fr);gap:2px;padding:0 14px;margin-bottom:6px;flex-shrink:0}
.cal-head{text-align:center;font-size:9px;font-weight:700;color:var(--muted);font-family:'DM Mono',monospace;padding:3px 0;letter-spacing:1px}
.cal-day{text-align:center;padding:5px 2px;border-radius:7px;font-size:12px;cursor:pointer;color:var(--text);min-height:30px;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:2px;font-weight:500;transition:background .15s}
.cal-day:active{background:var(--card2)}
.cal-day.today{background:var(--accent);color:#000;font-weight:700}
.cal-day.has-data::after{content:"";width:4px;height:4px;border-radius:50%;background:var(--green);display:block}
.cal-day.today.has-data::after{background:#000}
.cal-day.empty{pointer-events:none;opacity:0}
.cal-detail{background:var(--card);border-radius:12px;margin:0 16px;padding:13px;border:1px solid var(--border)}
.cal-det-date{font-family:'DM Mono',monospace;font-size:10px;color:var(--accent);font-weight:700;letter-spacing:2px;margin-bottom:9px;text-transform:uppercase}
.cp-brand-row{display:flex;gap:6px;padding:0 16px;margin-bottom:10px;overflow-x:auto;scrollbar-width:none;flex-shrink:0}
.cp-brand-row::-webkit-scrollbar{display:none}
.cp-brand-btn{padding:6px 15px;border-radius:20px;border:1.5px solid var(--border);background:var(--card2);color:var(--muted);font-size:10px;cursor:pointer;white-space:nowrap;font-family:'DM Mono',monospace;font-weight:600;text-transform:uppercase;flex-shrink:0;transition:all .15s}
.cp-brand-btn.on{background:var(--accent);color:#000;border-color:var(--accent)}
.cp-idea{background:var(--card);border-radius:12px;margin:0 16px 9px;padding:13px;border:1px solid var(--border)}
.cp-type{font-size:8px;letter-spacing:2px;text-transform:uppercase;font-family:'DM Mono',monospace;color:var(--accent);font-weight:700;margin-bottom:3px}
.cp-idea-txt{font-size:14px;font-weight:600;color:var(--text);margin-bottom:5px;line-height:1.4}
.cp-caption{font-size:12px;color:var(--muted);line-height:1.5;margin-bottom:8px;font-style:italic}
.cp-meta{display:flex;gap:5px;flex-wrap:wrap;margin-bottom:9px}
.cp-tag{font-size:9px;padding:2px 8px;border-radius:9px;font-family:'DM Mono',monospace;font-weight:600}
.cp-tag.platform{background:rgba(91,155,213,.1);color:var(--blue)}
.cp-tag.format{background:rgba(92,184,92,.1);color:var(--green)}
.cp-cvt{background:none;border:1.5px solid var(--border);border-radius:6px;padding:5px 12px;font-size:11px;cursor:pointer;color:var(--muted);font-family:'DM Sans',sans-serif;font-weight:500;margin-right:5px;transition:all .15s}
.cp-cvt:active{background:var(--card2);color:var(--text)}
.setr{display:flex;align-items:center;justify-content:space-between;padding:15px 0;border-bottom:1px solid var(--border)}.setr:last-child{border-bottom:none}
.setl{font-size:14px;font-weight:600;color:var(--text)}.setd{font-size:10px;color:var(--muted);margin-top:2px}
.tog{width:43px;height:23px;background:var(--muted2);border-radius:12px;position:relative;cursor:pointer;transition:background .2s;flex-shrink:0}
.tog.on{background:var(--accent)}.tog::after{content:"";position:absolute;width:17px;height:17px;background:#fff;border-radius:50%;top:3px;left:3px;transition:left .2s}.tog.on::after{left:23px}
.theme-grid{display:grid;grid-template-columns:1fr 1fr;gap:7px;margin-top:7px}
.theme-btn{border:2px solid var(--border);border-radius:10px;padding:9px 4px;cursor:pointer;text-align:center;transition:all .2s;background:none}
.theme-btn.active{border-color:var(--accent)}
.theme-sw{width:30px;height:30px;border-radius:9px;margin:0 auto 5px}
.theme-lbl{font-size:9px;letter-spacing:1px;color:var(--muted);text-transform:uppercase;font-family:'DM Mono',monospace;font-weight:600}
.theme-btn.active .theme-lbl{color:var(--accent)}
.fs-slider{-webkit-appearance:none;appearance:none;width:100%;height:4px;background:var(--border);border-radius:2px;outline:none;border:none;padding:0;margin-bottom:0;accent-color:var(--accent)}
.fs-slider::-webkit-slider-thumb{-webkit-appearance:none;width:17px;height:17px;border-radius:50%;background:var(--accent);cursor:pointer}
.save-btn{width:100%;background:var(--accent);border:none;border-radius:10px;color:#000;font-weight:700;font-size:13px;padding:13px;cursor:pointer;font-family:'DM Sans',sans-serif;margin-top:4px}
.save-status{font-size:10px;color:var(--muted);font-family:'DM Mono',monospace;text-align:center;margin-top:7px}
.dc2{background:var(--card);border-radius:12px;margin:0 16px 9px;padding:14px;border:1px solid var(--border)}
.dto{font-size:8px;color:var(--muted);letter-spacing:2px;text-transform:uppercase;font-family:'DM Mono',monospace;margin-bottom:3px;font-weight:600}
.dn2{font-size:14px;font-weight:700;color:var(--accent);margin-bottom:9px;display:flex;justify-content:space-between;align-items:center}
.dea{width:100%;min-height:75px;resize:vertical;font-size:12px;line-height:1.6;padding:8px 11px;border-left:3px solid var(--accent);border-radius:0 6px 6px 0;border-top:none;border-right:none;border-bottom:none;margin-bottom:0}
.dtag{font-size:10px;margin-top:9px;color:var(--muted);font-family:'DM Mono',monospace}
.cc{background:var(--card);border-radius:12px;margin:0 16px 9px;padding:14px;border:1px solid var(--border)}
.cday{font-size:10px;color:var(--accent);letter-spacing:2px;text-transform:uppercase;font-family:'DM Mono',monospace;margin-bottom:2px;font-weight:700}
.ctime2{font-size:10px;color:var(--muted);margin-bottom:7px;font-family:'DM Mono',monospace}
.cact{font-size:14px;font-weight:700;margin-bottom:5px;color:var(--text)}
.cnote2{font-size:12px;color:var(--muted);line-height:1.5}
.ctgt{font-size:10px;color:var(--green);margin-top:7px;font-family:'DM Mono',monospace;font-weight:600}
.analysis-row{display:flex;align-items:center;justify-content:space-between;padding:10px 0;border-bottom:1px solid var(--border)}.analysis-row:last-child{border-bottom:none}
.analysis-name{font-size:12px;font-weight:600;color:var(--text)}
.analysis-meta{font-size:10px;color:var(--muted);margin-top:2px;font-family:'DM Mono',monospace}
.analysis-amt{font-size:12px;font-weight:700;font-family:'DM Mono',monospace;color:var(--green)}
.week-day{margin-bottom:14px}
.week-hdr{font-family:'Bebas Neue',sans-serif;font-size:15px;letter-spacing:3px;color:var(--accent);margin-bottom:5px;padding:0 16px}
.week-card{background:var(--card);border-radius:11px;margin:0 16px;padding:3px 13px;border:1px solid var(--border)}
.week-row{display:flex;align-items:flex-start;gap:9px;padding:9px 0;border-bottom:1px solid var(--border)}.week-row:last-child{border-bottom:none}
.week-time{font-size:10px;color:var(--accent);font-family:'DM Mono',monospace;width:36px;flex-shrink:0;margin-top:2px;font-weight:600}
.week-txt{font-size:12px;flex:1;line-height:1.4;color:var(--text);font-weight:500}
.week-txt.done{text-decoration:line-through;opacity:.45}
.week-dot{width:6px;height:6px;border-radius:50%;background:var(--red);flex-shrink:0;margin-top:4px}
.pri-item{display:flex;align-items:center;gap:11px;padding:12px 18px;border-bottom:1px solid var(--border);cursor:pointer}
.pri-dot{width:7px;height:7px;border-radius:50%;flex-shrink:0}
.pri-txt{flex:1;font-size:14px;font-weight:500;color:var(--text);line-height:1.4}
.pri-check{width:21px;height:21px;border:2px solid var(--muted2);border-radius:50%;flex-shrink:0;transition:all .2s}
.meal-card{background:var(--card);border-radius:14px;margin:0 16px 12px;padding:14px;border:1px solid var(--border)}
.meal-day-hdr{font-family:'Bebas Neue',sans-serif;font-size:14px;letter-spacing:2px;color:var(--accent);margin-bottom:10px}
.meal-slot{display:flex;align-items:center;gap:10px;padding:8px 0;border-bottom:1px solid var(--border)}
.meal-slot:last-child{border-bottom:none}
.meal-time-lbl{font-size:9px;color:var(--muted);font-family:'DM Mono',monospace;font-weight:600;letter-spacing:1px;width:40px;flex-shrink:0;text-transform:uppercase}
.meal-name{flex:1;font-size:13px;color:var(--text);font-weight:500}
.meal-cal{font-size:9px;color:var(--muted);font-family:'DM Mono',monospace}
.fin-tx-item{display:flex;align-items:flex-start;gap:10px;padding:10px 0;border-bottom:1px solid var(--border)}
.fin-tx-item:last-child{border-bottom:none}
.bizrow{display:flex;gap:8px;padding:0 16px;margin-bottom:12px;overflow-x:auto;scrollbar-width:none}
.bizrow::-webkit-scrollbar{display:none}
.bizcard{flex:0 0 auto;background:var(--card);border-radius:12px;padding:12px 10px;text-align:center;border:1px solid var(--border);min-width:90px}
.bizlogo{width:40px;height:40px;border-radius:9px;margin:0 auto 7px;overflow:hidden;display:flex;align-items:center;justify-content:center}
.bizname{font-size:9px;color:var(--muted);margin-bottom:4px;font-family:'DM Mono',monospace;font-weight:600}
.bizval{font-size:11px;font-weight:700;font-family:'DM Mono',monospace;color:var(--green)}
#pwa-banner{position:fixed;bottom:0;left:0;right:0;background:var(--card);border-top:2px solid var(--accent);padding:14px 18px;z-index:9999;display:none;align-items:center;gap:12px}
#pwa-banner.show{display:flex}
.pwa-txt{flex:1;font-size:12px;color:var(--text);line-height:1.5}
.pwa-txt strong{color:var(--accent);font-family:'Bebas Neue',sans-serif;font-size:15px;letter-spacing:2px;display:block;margin-bottom:2px}
.pwa-btn{background:var(--accent);border:none;border-radius:8px;color:#000;font-weight:700;font-size:11px;padding:9px 14px;cursor:pointer;white-space:nowrap;flex-shrink:0}
.pwa-close{background:none;border:none;color:var(--muted);font-size:18px;cursor:pointer;flex-shrink:0;padding:0 4px}
/* BUI BILLING STYLES */
.bui-section{padding:0 16px 8px;flex-shrink:0}
.bui-day-label{font-family:'DM Mono',monospace;font-size:9px;letter-spacing:2px;color:var(--accent);text-transform:uppercase;font-weight:700;padding:12px 0 6px}
.bui-entry{display:flex;align-items:center;gap:10px;padding:11px 14px;background:var(--card);border-radius:10px;margin-bottom:6px;border:1px solid var(--border);cursor:pointer;transition:all .15s}
.bui-entry.bui-done{opacity:.45;border-left:3px solid var(--green)}
.bui-entry.bui-borrow{border-left:3px solid var(--blue)}
.bui-entry.bui-pending{border-left:3px solid var(--accent)}
.bui-check{width:20px;height:20px;border-radius:5px;border:2px solid var(--muted2);flex-shrink:0;display:flex;align-items:center;justify-content:center;transition:all .15s}
.bui-check.checked{background:var(--green);border-color:var(--green)}
.bui-check.checked::after{content:'✓';font-size:10px;color:#fff;font-weight:700}
.bui-info{flex:1;min-width:0}
.bui-name{font-size:13px;font-weight:600;color:var(--text)}
.bui-ref{font-size:10px;color:var(--muted);margin-top:1px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.bui-time{font-size:9px;color:var(--muted);font-family:'DM Mono',monospace;margin-top:2px}
.bui-right{text-align:right;flex-shrink:0}
.bui-amt{font-family:'DM Mono',monospace;font-size:14px;font-weight:700;color:var(--text)}
.bui-tag{font-size:8px;font-family:'DM Mono',monospace;padding:2px 6px;border-radius:3px;margin-top:3px;display:inline-block;text-transform:uppercase;letter-spacing:.05em}
.bui-tag-income{background:rgba(92,184,92,.12);color:var(--green)}
.bui-tag-borrow{background:rgba(91,155,213,.12);color:var(--blue)}
.bui-tag-pending{background:rgba(212,168,67,.12);color:var(--accent)}
.bui-stats{display:grid;grid-template-columns:1fr 1fr 1fr;gap:8px;padding:0 16px 12px}
.bui-stat{background:var(--card);border-radius:11px;padding:11px;border:1px solid var(--border)}
.bui-stat-lbl{font-size:8px;color:var(--muted);letter-spacing:1px;text-transform:uppercase;font-family:'DM Mono',monospace;font-weight:600;margin-bottom:4px}
.bui-stat-val{font-size:13px;font-weight:700;font-family:'DM Mono',monospace}
.bui-filter-row{display:flex;gap:6px;padding:0 16px 10px;overflow-x:auto;scrollbar-width:none;flex-shrink:0}
.bui-filter-row::-webkit-scrollbar{display:none}
::-webkit-scrollbar{width:3px;height:3px}
::-webkit-scrollbar-thumb{background:var(--border);border-radius:3px}
</style>
</head>
<body class="fs-md">

<div id="save-indicator">SAVED</div>
<div id="notif-bar"></div>

<div id="splash">
  <div class="splash-inner">
    <div class="splash-c">C</div>
    <div class="splash-sub">Operating System</div>
  </div>
</div>

<div id="pwa-banner">
  <div class="pwa-txt">
    <strong>ADD TO HOME SCREEN</strong>
    Install COLE OS for offline access & app-like experience
  </div>
  <button class="pwa-btn" id="pwa-install-btn">Install</button>
  <button class="pwa-close" onclick="dismissPWA()">×</button>
</div>

<div class="edit-modal-overlay" id="editModal">
  <div class="edit-modal">
    <div class="edit-modal-header">
      <div class="edit-modal-title">EDIT TASK</div>
      <button class="edit-modal-close" onclick="closeEditModal()">Cancel</button>
    </div>
    <div class="edit-modal-field"><div class="edit-modal-label">Task Title</div><input id="edit-task-text" type="text" placeholder="Task title"></div>
    <div class="edit-modal-field"><div class="edit-modal-label">Amount (optional)</div><input id="edit-task-amount" type="text" placeholder="e.g. ₦50,000"></div>
    <div class="edit-modal-field"><div class="edit-modal-label">Day</div>
      <select id="edit-task-day"><option value="">No Day</option><option value="Monday">Monday</option><option value="Tuesday">Tuesday</option><option value="Wednesday">Wednesday</option><option value="Thursday">Thursday</option><option value="Friday">Friday</option><option value="Saturday">Saturday</option><option value="Sunday">Sunday</option></select>
    </div>
    <div class="edit-modal-field"><div class="edit-modal-label">Time</div><input id="edit-task-time" type="time"></div>
    <div class="edit-modal-field"><div class="edit-modal-label">Category</div>
      <select id="edit-task-tag"><option value="personal">Personal</option><option value="urgent">Urgent</option><option value="client">Client — Money In</option><option value="expense">Expense — Money Out</option><option value="content">Content</option></select>
    </div>
    <button class="edit-modal-save" onclick="saveTaskEdit()">Save Changes</button>
  </div>
</div>

<div id="homepage">
  <div class="home-topbar">
    <div class="menu-btn" onclick="openMenu()">
      <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
    </div>
    <div class="search-wrap">
      <svg class="s-icon" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
      <input class="search-inp" id="search-input" placeholder="Search tasks, finance, content..." oninput="doSearch(this.value)" onfocus="doSearch(this.value)">
      <div id="search-results"></div>
    </div>
  </div>
  <div class="scroll-body" style="padding-bottom:20px">
    <div class="home-greet-area">
      <div class="home-greeting" id="home-greet">COLE</div>
      <div class="home-tagline" id="home-tagline">Stay focused. Stay consistent. Get everything.</div>
      <div class="home-date-badge">
        <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
        <span class="home-date-txt" id="home-date-lbl">Loading...</span>
      </div>
    </div>
    <div class="home-stats">
      <div class="hstat" onclick="openCat('finance')"><div class="hstat-lbl">Balance</div><div class="hstat-val" id="hqs-balance" style="color:var(--green)">₦0</div></div>
      <div class="hstat" onclick="openCat('tasks')"><div class="hstat-lbl">Active Tasks</div><div class="hstat-val" id="hqs-tasks" style="color:var(--accent)">0</div></div>
      <div class="hstat" onclick="openCat('finance')"><div class="hstat-lbl">Money In</div><div class="hstat-val" id="hqs-in" style="color:var(--green)">₦0</div></div>
      <div class="hstat" onclick="openCat('finance')"><div class="hstat-lbl">Money Out</div><div class="hstat-val" id="hqs-out" style="color:var(--red)">₦0</div></div>
    </div>
    <div class="home-cats">
      <div class="home-cat" onclick="openCat('tasks')">
        <div class="hc-icon" style="background:rgba(212,168,67,.12)"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 11 12 14 22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></svg></div>
        <div class="hc-label">TASKS</div><div class="hc-sub" id="hmc-tasks-sub">0 pending</div>
      </div>
      <div class="home-cat" onclick="openCat('analysis')">
        <div class="hc-icon" style="background:rgba(91,155,213,.1)"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--blue)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg></div>
        <div class="hc-label">ANALYSIS</div><div class="hc-sub">Insights</div>
      </div>
      <div class="home-cat" onclick="openCat('finance')">
        <div class="hc-icon" style="background:rgba(92,184,92,.1)"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--green)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg></div>
        <div class="hc-label">FINANCE</div><div class="hc-sub" id="hmc-finance-sub">Balance</div>
      </div>
    </div>
    <div class="quote-card">
      <button class="quote-refresh" onclick="rotateQuote()" title="New quote">↻</button>
      <div class="quote-icon">❝</div>
      <div class="quote-txt" id="hqs-quote">The grind never lies. Everything you want is on the other side of consistent work.</div>
      <div class="quote-attr" id="hqs-quote-attr">— Daily Motivation</div>
    </div>
    <div style="padding:0 18px 10px;flex-shrink:0">
      <div style="font-size:9px;color:var(--muted);font-family:'DM Mono',monospace;letter-spacing:1.5px;font-weight:600;text-transform:uppercase;margin-bottom:8px">TOP PRIORITIES</div>
    </div>
    <div id="pri-list"></div>
  </div>
</div>

<div id="menu-overlay" onclick="closeMenu()"></div>
<div id="menu-drawer">
  <div class="md-header"><div class="md-logo">COLE</div><div class="md-sub">Operating System</div></div>
  <div class="md-sect">Navigate</div>
  <div class="md-item" onclick="openCat('tasks');closeMenu()"><div class="md-icon" style="background:rgba(212,168,67,.12)"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 11 12 14 22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></svg></div><div class="md-label">Tasks</div><div class="md-chevron">›</div></div>
  <div class="md-item" onclick="openSec('bui');closeMenu()"><div class="md-icon" style="background:rgba(212,168,67,.1)"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="2" stroke-linecap="round"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg></div><div class="md-label">Billing (BUI)</div><div class="md-chevron">›</div></div>
  <div class="md-item" onclick="openCat('analysis');closeMenu()"><div class="md-icon" style="background:rgba(91,155,213,.1)"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--blue)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg></div><div class="md-label">Analysis</div><div class="md-chevron">›</div></div>
  <div class="md-item" onclick="openCat('finance');closeMenu()"><div class="md-icon" style="background:rgba(92,184,92,.1)"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--green)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg></div><div class="md-label">Finance</div><div class="md-chevron">›</div></div>
  <div class="md-item" onclick="openSec('meals');closeMenu()"><div class="md-icon" style="background:rgba(224,82,82,.08)"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--red)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 2v7c0 1.1.9 2 2 2h4a2 2 0 0 0 2-2V2"/><path d="M7 2v20"/><path d="M21 15V2v0a5 5 0 0 0-5 5v6c0 1.1.9 2 2 2h3zm0 0v7"/></svg></div><div class="md-label">Meal Tracker</div><div class="md-chevron">›</div></div>
  <div class="md-sect">System</div>
  <div class="md-item" onclick="openSec('settings');closeMenu()"><div class="md-icon" style="background:rgba(107,114,128,.1)"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--muted)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg></div><div class="md-label">Settings</div><div class="md-chevron">›</div></div>
</div>

<!-- TASK CATEGORY -->
<div class="cat-overlay" id="cat-tasks">
  <div class="pg-header"><button class="pg-back" onclick="closeCat('tasks')">‹</button><div class="pg-title">TASKS</div></div>
  <div class="scroll-body">
    <div class="cat-list-item" onclick="openSec('tasks')"><div class="cli-icon" style="background:rgba(212,168,67,.12)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 11 12 14 22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></svg></div><div style="flex:1"><div class="cli-name">Tasks</div><div class="cli-desc">All your tasks</div></div><div class="cli-arrow">›</div></div>
    <div class="cat-list-item" onclick="openSec('bui')"><div class="cli-icon" style="background:rgba(212,168,67,.1)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="2" stroke-linecap="round"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg></div><div style="flex:1"><div class="cli-name">Billing — BUI</div><div class="cli-desc">Ileya activation income tracker</div></div><div class="cli-arrow">›</div></div>
    <div class="cat-list-item" onclick="openSec('content')"><div class="cli-icon" style="background:rgba(91,155,213,.1)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--blue)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/></svg></div><div style="flex:1"><div class="cli-name">Content Planner</div><div class="cli-desc">Weekly content ideas</div></div><div class="cli-arrow">›</div></div>
    <div class="cat-list-item" onclick="openSec('week')"><div class="cli-icon" style="background:rgba(92,184,92,.1)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--green)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg></div><div style="flex:1"><div class="cli-name">Week Plan</div><div class="cli-desc">Auto-generated schedule</div></div><div class="cli-arrow">›</div></div>
    <div class="cat-list-item" onclick="openSec('cta')"><div class="cli-icon" style="background:rgba(107,114,128,.1)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--muted)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg></div><div style="flex:1"><div class="cli-name">Call to Action</div><div class="cli-desc">Day-by-day execution</div></div><div class="cli-arrow">›</div></div>
    <div class="cat-list-item" onclick="openSec('drafts')"><div class="cli-icon" style="background:rgba(212,168,67,.08)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg></div><div style="flex:1"><div class="cli-name">Draft Texts</div><div class="cli-desc">Messages ready to send</div></div><div class="cli-arrow">›</div></div>
  </div>
</div>

<!-- ANALYSIS CATEGORY -->
<div class="cat-overlay" id="cat-analysis">
  <div class="pg-header"><button class="pg-back" onclick="closeCat('analysis')">‹</button><div class="pg-title">ANALYSIS</div></div>
  <div class="scroll-body">
    <div class="cat-list-item" onclick="openSec('analytics')"><div class="cli-icon" style="background:rgba(91,155,213,.1)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--blue)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg></div><div style="flex:1"><div class="cli-name">Analytics</div><div class="cli-desc">Charts & performance</div></div><div class="cli-arrow">›</div></div>
    <div class="cat-list-item" onclick="openSec('dashboard')"><div class="cli-icon" style="background:rgba(212,168,67,.1)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg></div><div style="flex:1"><div class="cli-name">Dashboard</div><div class="cli-desc">Overview & balance</div></div><div class="cli-arrow">›</div></div>
    <div class="cat-list-item" onclick="openSec('calendar')"><div class="cli-icon" style="background:rgba(92,184,92,.1)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--green)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg></div><div style="flex:1"><div class="cli-name">Calendar</div><div class="cli-desc">View by date</div></div><div class="cli-arrow">›</div></div>
  </div>
</div>

<!-- FINANCE CATEGORY -->
<div class="cat-overlay" id="cat-finance">
  <div class="pg-header"><button class="pg-back" onclick="closeCat('finance')">‹</button><div class="pg-title">FINANCE</div></div>
  <div class="scroll-body">
    <div class="cat-list-item" onclick="openSec('money')"><div class="cli-icon" style="background:rgba(92,184,92,.1)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--green)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg></div><div style="flex:1"><div class="cli-name">Money</div><div class="cli-desc">Payments, balance, credit</div></div><div class="cli-arrow">›</div></div>
    <div class="cat-list-item" onclick="openSec('finance')"><div class="cli-icon" style="background:rgba(91,155,213,.1)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--blue)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="5" width="20" height="14" rx="2"/><line x1="2" y1="10" x2="22" y2="10"/></svg></div><div style="flex:1"><div class="cli-name">Business Finance</div><div class="cli-desc">Log income & expenses</div></div><div class="cli-arrow">›</div></div>
    <div class="cat-list-item" onclick="openSec('credits')"><div class="cli-icon" style="background:rgba(224,82,82,.1)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--red)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="5" width="20" height="14" rx="2"/><line x1="2" y1="10" x2="22" y2="10"/><line x1="6" y1="15" x2="10" y2="15"/></svg></div><div style="flex:1"><div class="cli-name">Credit</div><div class="cli-desc">Outstanding credit & debts</div></div><div class="cli-arrow">›</div></div>
  </div>
</div>

<!-- TASKS PAGE -->
<div class="sec-page" id="sec-tasks">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('tasks')">‹</button><div class="pg-title">TASKS</div></div>
  <div class="add-bar">
    <div class="add-row"><input class="add-inp" id="t-in" placeholder="Add a task..." onkeydown="if(event.key==='Enter')addTask()"><button class="add-btn" onclick="addTask()">+</button></div>
    <div class="add-extra"><select id="t-tag"><option value="personal">Personal</option><option value="urgent">Urgent</option><option value="client">Client — Money In</option><option value="expense">Expense — Money Out</option><option value="content">Content</option></select><input type="text" id="t-amt" placeholder="₦ Amount (optional)"></div>
    <div class="add-extra2"><select id="t-day"><option value="">No Day</option><option value="Monday">Monday</option><option value="Tuesday">Tuesday</option><option value="Wednesday">Wednesday</option><option value="Thursday">Thursday</option><option value="Friday">Friday</option><option value="Saturday">Saturday</option><option value="Sunday">Sunday</option></select><input type="time" id="t-time"></div>
  </div>
  <div class="task-hdr"><div class="task-title">TASKS</div><div class="task-cnt" id="t-header">0/0</div></div>
  <div class="prog-wrap"><div class="prog-bg"><div class="prog-fill" id="t-prog" style="width:0%"></div></div><div class="prog-meta"><span id="t-pl">0 done</span><span id="t-pp" style="color:var(--accent)">0%</span></div></div>
  <div class="filter-row"><div class="chip active" onclick="filterT('all',this)">All</div><div class="chip" onclick="filterT('urgent',this)">Urgent</div><div class="chip" onclick="filterT('client',this)">Client</div><div class="chip" onclick="filterT('expense',this)">Expense</div><div class="chip" onclick="filterT('personal',this)">Personal</div><div class="chip" onclick="filterT('content',this)">Content</div></div>
  <div class="scroll-body" style="padding-bottom:20px"><div id="task-container"></div></div>
</div>

<!-- BUI BILLING PAGE -->
<div class="sec-page" id="sec-bui">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('bui')">‹</button><div class="pg-title">BILLING — BUI</div></div>
  <div class="bui-stats">
    <div class="bui-stat"><div class="bui-stat-lbl">Expected</div><div class="bui-stat-val" id="bui-expected" style="color:var(--accent)">₦0</div></div>
    <div class="bui-stat"><div class="bui-stat-lbl">Received</div><div class="bui-stat-val" id="bui-received" style="color:var(--green)">₦0</div></div>
    <div class="bui-stat"><div class="bui-stat-lbl">Pending</div><div class="bui-stat-val" id="bui-pending" style="color:var(--red)">₦0</div></div>
  </div>
  <div class="bui-filter-row">
    <div class="chip active" onclick="filterBUI('all',this)">All</div>
    <div class="chip" onclick="filterBUI('pending',this)">Pending</div>
    <div class="chip" onclick="filterBUI('done',this)">Received</div>
    <div class="chip" onclick="filterBUI('borrow',this)">Borrowed</div>
  </div>
  <div class="scroll-body" style="padding-bottom:20px"><div id="bui-list" style="padding:0 16px"></div></div>
</div>

<!-- DASHBOARD PAGE -->
<div class="sec-page" id="sec-dashboard">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('dashboard')">‹</button><div class="pg-title">DASHBOARD</div></div>
  <div class="scroll-body"><div style="height:8px"></div>
    <div class="bal-hero"><div class="bal-lbl">Current Balance</div><div class="bal-val" id="dash-balance">₦0</div><div class="bal-sub" id="dash-bal-sub">Money In minus Money Out</div></div>
    <div class="fin-grid">
      <div class="fin-card"><div class="fin-lbl" style="color:var(--green)">Money In</div><div class="fin-val" style="color:var(--green)" id="dash-moneyin">₦0</div><div class="fin-sub" id="dash-moneyin-sub">0 received</div></div>
      <div class="fin-card"><div class="fin-lbl" style="color:var(--red)">Money Out</div><div class="fin-val" style="color:var(--red)" id="dash-moneyout">₦0</div><div class="fin-sub" id="dash-moneyout-sub">0 paid</div></div>
      <div class="fin-card"><div class="fin-lbl" style="color:var(--blue)">Expected In</div><div class="fin-val" style="color:var(--blue)" id="dash-expected">₦0</div><div class="fin-sub" id="dash-expected-sub">0 pending</div></div>
      <div class="fin-card"><div class="fin-lbl" style="color:var(--accent)">Total Bills</div><div class="fin-val" style="color:var(--accent)" id="dash-bills">₦0</div><div class="fin-sub" id="dash-bills-sub">0 expenses</div></div>
    </div>
    <div class="sl">BUSINESS OVERVIEW</div><div class="bizrow" id="dash-biz"></div>
    <div class="tov"><div class="ct">TASKS OVERVIEW</div><div class="tovi"><div class="dw"><svg width="88" height="88" viewBox="0 0 90 90"><circle cx="45" cy="45" r="35" fill="none" stroke="var(--border)" stroke-width="10"/><circle id="d-done" cx="45" cy="45" r="35" fill="none" stroke="var(--accent)" stroke-width="10" stroke-dasharray="0 220" stroke-linecap="round"/></svg><div class="dc"><div class="dn" id="d-total">0</div><div class="dl">Tasks</div></div></div><div class="leg"><div class="li"><div class="ld" style="background:var(--green)"></div><span id="leg-done">0 Completed</span></div><div class="li"><div class="ld" style="background:var(--red)"></div><span id="leg-pend">0 Pending</span></div><div class="li"><div class="ld" style="background:var(--blue)"></div><span id="leg-client">0 Client tasks</span></div><div class="li"><div class="ld" style="background:var(--accent)"></div><span id="leg-expense">0 Expense tasks</span></div></div></div></div>
    <div class="card"><div class="ct">TRANSACTION HISTORY</div><div id="dash-tx-list"><div class="empty-state">Complete tasks to see transactions</div></div></div>
  </div>
</div>

<!-- MONEY PAGE -->
<div class="sec-page" id="sec-money">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('money')">‹</button><div class="pg-title">MONEY</div></div>
  <div class="scroll-body"><div style="height:8px"></div>
    <div class="sbal-card"><div class="sbal-lbl">Starting Balance</div><div class="sbal-row"><input class="sbal-inp" id="sbal-input" type="text" placeholder="₦ Enter your balance"><button class="sbal-btn" onclick="saveStartingBalance()">Set</button></div><div style="font-size:9px;color:var(--muted);margin-top:7px;font-family:'DM Mono',monospace" id="sbal-note">Enter your current cash or bank balance</div></div>
    <div class="msum"><div class="msc"><div class="msl">Balance</div><div class="msv" id="m-balance" style="color:var(--green)">₦0</div></div><div class="msc"><div class="msl">In</div><div class="msv" id="m-moneyin" style="color:var(--green)">₦0</div></div><div class="msc"><div class="msl">Out</div><div class="msv" id="m-moneyout" style="color:var(--red)">₦0</div></div></div>
    <div class="card"><div class="ct" style="display:flex;justify-content:space-between;align-items:center"><span>PENDING CLIENT PAYMENTS</span><span id="m-expected-total" style="color:var(--blue);font-family:'DM Mono',monospace;font-size:11px"></span></div><div id="m-pending-clients"></div></div>
    <div class="card"><div class="ct" style="display:flex;justify-content:space-between;align-items:center"><span>PENDING EXPENSES</span><span id="m-bills-total" style="color:var(--accent);font-family:'DM Mono',monospace;font-size:11px"></span></div><div id="m-pending-expenses"></div></div>
    <div class="card"><div class="ct">RECEIVED PAYMENTS</div><div id="m-received"></div></div>
    <div class="card"><div class="ct">PAID EXPENSES</div><div id="m-paid"></div></div>
    <div class="card"><div class="ct">STANDING CREDIT / LOANS</div><div id="loans-list"></div></div>
  </div>
</div>

<!-- FINANCE PAGE -->
<div class="sec-page" id="sec-finance">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('finance')">‹</button><div class="pg-title">BUSINESS FINANCE</div></div>
  <div class="scroll-body"><div style="height:8px"></div>
    <div class="card"><div class="ct">ADD TRANSACTION</div>
      <select id="tx-type" style="margin-bottom:8px"><option value="income">Income</option><option value="expense">Expense</option></select>
      <input id="tx-desc" placeholder="Description" style="margin-bottom:8px">
      <div class="r2" style="margin-bottom:8px"><input id="tx-amount" type="number" placeholder="Amount ₦"><input id="tx-date" type="date"></div>
      <select id="tx-cat" style="margin-bottom:8px"><option value="sales">Sales / Orders</option><option value="services">Services</option><option value="materials">Materials / Stock</option><option value="rent">Rent / Utilities</option><option value="marketing">Marketing</option><option value="salary">Salary / Wages</option><option value="other">Other</option></select>
      <select id="tx-biz" style="margin-bottom:8px"><option value="salon">Salon</option><option value="nails">Nail Brand</option><option value="clothing">Clothing Brand</option></select>
      <button class="btn-pk" onclick="addTransaction()">+ Add Transaction</button>
    </div>
    <div class="card"><div class="ct" style="display:flex;justify-content:space-between;align-items:center"><span>TRANSACTIONS</span><span id="tx-count" style="color:var(--accent);font-family:'DM Mono',monospace;font-size:11px">0</span></div>
      <div style="display:flex;gap:5px;margin-bottom:10px;overflow-x:auto"><button class="fchip on" onclick="filterTx('all',this)">All</button><button class="fchip" onclick="filterTx('income',this)">Income</button><button class="fchip" onclick="filterTx('expense',this)">Expense</button><button class="fchip" onclick="filterTx('salon',this)">Salon</button><button class="fchip" onclick="filterTx('nails',this)">Nails</button><button class="fchip" onclick="filterTx('clothing',this)">Clothing</button></div>
      <div id="tx-list"><div class="empty-state">No transactions yet</div></div>
    </div>
  </div>
</div>

<!-- ANALYTICS PAGE -->
<div class="sec-page" id="sec-analytics">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('analytics')">‹</button><div class="pg-title">ANALYTICS</div></div>
  <div class="filter-bar"><div class="frow"><div class="fchip on" onclick="setDateFilter('month',this)">This Month</div><div class="fchip" onclick="setDateFilter('week',this)">This Week</div><div class="fchip" onclick="setDateFilter('lastweek',this)">Last Week</div><div class="fchip" onclick="setDateFilter('lastmonth',this)">Last Month</div><div class="fchip" onclick="setDateFilter('custom',this)">Custom</div></div><div class="fdate-row" id="custom-date-row" style="display:none"><input type="date" id="filter-start"><span style="color:var(--muted);font-size:12px;flex-shrink:0">to</span><input type="date" id="filter-end"><button class="fapply" onclick="applyCustomFilter()">Apply</button></div></div>
  <div class="scroll-body"><div style="padding:9px 16px 3px;font-size:9px;color:var(--muted);font-family:'DM Mono',monospace;letter-spacing:1px" id="ana-range-label">Showing: Current Month</div>
    <div class="ana-grid"><div class="ana-card"><div class="ana-lbl" style="color:var(--green)">Income</div><div class="ana-val" style="color:var(--green)" id="ana-income">₦0</div><div class="ana-sub" id="ana-income-trend"></div></div><div class="ana-card"><div class="ana-lbl" style="color:var(--red)">Expenses</div><div class="ana-val" style="color:var(--red)" id="ana-expense">₦0</div><div class="ana-sub" id="ana-expense-trend"></div></div><div class="ana-card"><div class="ana-lbl">Net Profit</div><div class="ana-val" id="ana-profit">₦0</div><div class="ana-sub" id="ana-profit-sub"></div></div><div class="ana-card"><div class="ana-lbl">Transactions</div><div class="ana-val" id="ana-txcount">0</div><div class="ana-sub">in period</div></div></div>
    <div style="padding:0 16px;margin-bottom:10px"><div style="display:flex;gap:8px"><div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:11px;padding:11px;text-align:center"><div style="font-size:8px;color:var(--muted);font-family:'DM Mono',monospace;font-weight:600;letter-spacing:1px;margin-bottom:3px">THIS WEEK</div><div style="font-size:13px;font-weight:700;font-family:'DM Mono',monospace;color:var(--green)" id="ana-thisweek-inc">₦0</div><div style="font-size:9px;color:var(--muted);margin-top:2px">income</div></div><div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:11px;padding:11px;text-align:center"><div style="font-size:8px;color:var(--muted);font-family:'DM Mono',monospace;font-weight:600;letter-spacing:1px;margin-bottom:3px">LAST WEEK</div><div style="font-size:13px;font-weight:700;font-family:'DM Mono',monospace;color:var(--muted)" id="ana-lastweek-inc">₦0</div><div style="font-size:9px;color:var(--muted);margin-top:2px" id="ana-week-compare"></div></div></div></div>
    <div class="chart-card"><div class="ct">INCOME VS EXPENSES</div><canvas id="chart-bar" height="150"></canvas></div>
    <div class="chart-card"><div class="ct">EXPENSE BREAKDOWN</div><canvas id="chart-pie" height="170"></canvas></div>
    <div style="padding:3px 16px 3px"><div style="font-size:9px;color:var(--muted);font-family:'DM Mono',monospace;font-weight:600;letter-spacing:1.5px">SMART INSIGHTS</div></div>
    <div class="insight-card" id="insights-container"><div class="insight-item" style="color:var(--muted)">Log transactions to see insights.</div></div>
  </div>
</div>

<!-- CALENDAR PAGE -->
<div class="sec-page" id="sec-calendar">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('calendar')">‹</button><div class="pg-title">CALENDAR</div></div>
  <div class="cal-nav"><button class="cal-nav-btn" onclick="calPrev()">‹</button><div class="cal-month" id="cal-month-lbl">January 2025</div><button class="cal-nav-btn" onclick="calNext()">›</button></div>
  <div class="cal-grid7"><div class="cal-head">M</div><div class="cal-head">T</div><div class="cal-head">W</div><div class="cal-head">T</div><div class="cal-head">F</div><div class="cal-head">S</div><div class="cal-head">S</div></div>
  <div class="cal-grid7" id="cal-days" style="flex-shrink:0"></div>
  <div class="scroll-body"><div id="cal-detail-wrap" style="padding-bottom:8px"></div></div>
</div>

<!-- CONTENT PAGE -->
<div class="sec-page" id="sec-content">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('content')">‹</button><div class="pg-title">CONTENT</div></div>
  <div class="cp-brand-row"><button class="cp-brand-btn on" onclick="setCPBrand('salon',this)">Salon</button><button class="cp-brand-btn" onclick="setCPBrand('nails',this)">Nails</button><button class="cp-brand-btn" onclick="setCPBrand('clothing',this)">Clothing</button></div>
  <div style="padding:0 16px;margin-bottom:12px;flex-shrink:0"><button class="btn-pk" onclick="generateContentIdeas()">Generate Weekly Ideas</button></div>
  <div class="scroll-body"><div id="content-ideas-list"></div><div style="padding:3px 16px 3px;margin-top:4px;font-size:9px;color:var(--muted);font-family:'DM Mono',monospace;font-weight:600;letter-spacing:1.5px">SAVED IDEAS</div><div id="saved-content-list"></div></div>
</div>

<!-- WEEK PLAN PAGE -->
<div class="sec-page" id="sec-week">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('week')">‹</button><div class="pg-title">WEEK PLAN</div></div>
  <div class="scroll-body"><div class="card" style="background:rgba(212,168,67,.06);border-color:rgba(212,168,67,.15);margin-top:8px"><div style="font-size:12px;color:var(--muted)">Auto-generated from tasks with assigned days.</div></div><div id="week-container"></div></div>
</div>

<!-- MEALS PAGE -->
<div class="sec-page" id="sec-meals">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('meals')">‹</button><div class="pg-title">MEAL TRACKER</div></div>
  <div style="padding:0 16px 12px;flex-shrink:0"><button class="btn-pk" onclick="generateMeals()" style="margin-top:8px">🍽 Generate This Week's Meals</button></div>
  <div class="scroll-body"><div id="meals-container"><div class="empty-state" style="padding:40px">Tap above to generate your weekly Nigerian meal plan</div></div></div>
</div>

<!-- SETTINGS PAGE -->
<div class="sec-page" id="sec-settings">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('settings')">‹</button><div class="pg-title">SETTINGS</div></div>
  <div class="scroll-body"><div style="height:8px"></div>
    <div class="card"><div class="ct">DATA AND SAVE</div><div class="setr"><div><div class="setl">Auto-Save</div><div class="setd">Save on every change</div></div><div class="tog on" id="autosave-tog" onclick="toggleAutoSave()"></div></div><div style="padding-top:10px"><button class="save-btn" onclick="manualSave()">Save All Data Now</button><div class="save-status" id="save-status-text">Last saved: not yet</div></div></div>
    <div class="card"><div class="ct">THEME</div><div class="theme-grid">
      <button class="theme-btn" id="btn-theme-light" onclick="setTheme('light')"><div class="theme-sw" style="background:linear-gradient(135deg,#f5f0ea,#c2185b)"></div><div class="theme-lbl">Light</div></button>
      <button class="theme-btn active" id="btn-theme-gold" onclick="setTheme('gold')"><div class="theme-sw" style="background:linear-gradient(135deg,#0c0c0e,#d4a843)"></div><div class="theme-lbl">Gold</div></button>
      <button class="theme-btn" id="btn-theme-dark" onclick="setTheme('dark')"><div class="theme-sw" style="background:#000;border:1px solid #333"></div><div class="theme-lbl">Dark</div></button>
      <button class="theme-btn" id="btn-theme-chatgpt" onclick="setTheme('chatgpt')"><div class="theme-sw" style="background:linear-gradient(135deg,#0d0e12,#7c6aff)"></div><div class="theme-lbl">ChatGPT</div></button>
    </div></div>
    <div class="card"><div class="ct">TEXT SIZE</div><input type="range" class="fs-slider" id="fs-slider" min="0" max="3" step="1" value="1" oninput="setFontSize(this.value)" style="margin-bottom:0"><div style="display:flex;justify-content:space-between;margin-top:5px;font-size:9px;color:var(--muted);font-family:'DM Mono',monospace;font-weight:600"><span>Small</span><span>Medium</span><span>Large</span><span>XL</span></div><div style="font-size:14px;color:var(--accent);margin-top:7px;font-family:'DM Mono',monospace;font-weight:600" id="fs-preview">Medium</div></div>
    <div class="card"><div class="ct">GREETING</div><div class="setr"><div><div class="setl">Auto Greeting</div><div class="setd">Changes by time of day</div></div><div class="tog on" id="greet-tog" onclick="toggleAutoGreet()"></div></div></div>
    <div class="card"><div class="ct">NOTIFICATIONS</div><div class="setr"><div><div class="setl">Urgent Task Alerts</div></div><div class="tog on" id="notif-tog" onclick="toggleNotif()"></div></div><div class="setr"><div><div class="setl">Test Notification</div></div><button class="btn-gh" onclick="triggerTestNotif()">Test</button></div></div>
    <div class="card"><div class="ct">BUSINESSES</div><div id="biz-settings-list"></div><div style="padding-top:10px"><button class="btn-pk" onclick="addBiz()">+ Add Business</button></div></div>
    <div class="card" style="background:rgba(224,82,82,.05);border-color:rgba(224,82,82,.15)"><div class="ct" style="color:var(--red)">DANGER ZONE</div><button onclick="resetAllData()" style="width:100%;background:none;border:1.5px solid var(--red);color:var(--red);border-radius:10px;padding:12px;font-size:13px;cursor:pointer;font-family:'DM Sans',sans-serif;font-weight:600">Reset All App Data</button><div style="font-size:10px;color:var(--muted);text-align:center;margin-top:8px;font-family:'DM Mono',monospace">This cannot be undone</div></div>
  </div>
</div>

<!-- CREDITS PAGE -->
<div class="sec-page" id="sec-credits">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('credits')">‹</button><div class="pg-title">CREDIT</div></div>
  <div class="scroll-body"><div style="padding:8px 16px 4px;font-size:10px;color:var(--muted);font-family:'DM Mono',monospace;font-weight:600;letter-spacing:1px">Tick to mark cleared</div>
    <div class="card"><div id="credits-list"></div></div>
    <div style="padding:0 16px;margin-bottom:12px"><button class="btn-pk" onclick="addLoanPrompt()">+ Add Credit Entry</button></div>
    <div style="padding:4px 16px 4px"><div style="font-family:'Bebas Neue',sans-serif;font-size:18px;letter-spacing:2px;color:var(--text)">CLEARED CREDIT ANALYSIS</div></div>
    <div style="padding:0 16px 4px;font-size:10px;color:var(--muted);font-family:'DM Mono',monospace">Monthly log of cleared credit</div>
    <div id="cleared-analysis"></div>
  </div>
</div>

<!-- DRAFTS PAGE -->
<div class="sec-page" id="sec-drafts">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('drafts')">‹</button><div class="pg-title">DRAFT TEXTS</div></div>
  <div class="scroll-body">
    <div style="padding:4px 16px 10px;font-size:10px;color:var(--muted);font-family:'DM Mono',monospace;font-weight:600;letter-spacing:1px">TAP TEXT TO EDIT — ASSIGN TO RECIPIENT</div>
    <div style="padding:0 16px 10px"><button class="btn-pk" onclick="addDraft()">+ New Draft</button></div>
    <div id="drafts-list"></div>
  </div>
</div>

<!-- CTA PAGE -->
<div class="sec-page" id="sec-cta">
  <div class="pg-header"><button class="pg-back" onclick="closeSec('cta')">‹</button><div class="pg-title">CALL TO ACTION</div></div>
  <div class="scroll-body"><div id="cta-list"></div><div style="padding:0 16px 16px"><button class="btn-pk" onclick="addCta()">+ Add Action</button></div></div>
</div>

<script>
const SK='cole_v9_gbemi';
const WEEKDAYS=['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
const MONTHS_AR=['January','February','March','April','May','June','July','August','September','October','November','December'];

function sv(k,v){try{localStorage.setItem(k,JSON.stringify(v))}catch(e){}}
function ld(k,d){try{const v=localStorage.getItem(k);return v!==null?JSON.parse(v):d}catch(e){return d}}
function fmt(n){if(!n&&n!==0)return'₦0';const s=n<0?'-':'';return s+'₦'+Math.abs(n).toLocaleString()}
function parseAmt(s){if(!s)return 0;return parseInt(s.toString().replace(/[^\d]/g,''))||0}

window.addEventListener('load',()=>{
  setTimeout(()=>{const sp=document.getElementById('splash');if(sp){sp.classList.add('hide');setTimeout(()=>{sp.style.display='none'},700);}},1800);
});

// ═══════════════════ BUI DATA — EACH INSTALLMENT IS ITS OWN SEPARATE ENTRY ═══════════════════
const BUI_DATA = [
  {id:'b01',name:'Mom',date:'Mon May 19',time:'5:00PM',amount:50000,ref:'ongoing support',type:'income'},
  {id:'b02',name:'Margret',date:'Mon May 19',time:'6:00PM',amount:20000,ref:'support contribution',type:'income'},
  {id:'b03',name:'Jemil',date:'Mon May 19',time:'7:00PM',amount:5000,ref:'installment 1 of 2',type:'income'},
  {id:'b04',name:'Deola',date:'Mon May 19',time:'8:00PM',amount:3000,ref:'support contribution',type:'income'},
  {id:'b05',name:'Atimoe',date:'Mon May 19',time:'9:00PM',amount:5000,ref:'installment 1 of 3',type:'income'},
  {id:'b06',name:'Me',date:'Tue May 20',time:'10:00AM',amount:50000,ref:'project follow-up',type:'income'},
  {id:'b07',name:'Dami',date:'Tue May 20',time:'6:30PM',amount:20000,ref:'borrow — repay June 3',type:'borrow'},
  {id:'b08',name:'Bambam i',date:'Tue May 20',time:'7:00PM',amount:2000,ref:'installment 1 of 3',type:'income'},
  {id:'b09',name:'Tobi',date:'Tue May 20',time:'8:30PM',amount:2000,ref:'update reminder',type:'income'},
  {id:'b10',name:'Olamide',date:'Wed May 21',time:'5:00PM',amount:10000,ref:'project follow-up',type:'income'},
  {id:'b11',name:'Juju',date:'Wed May 21',time:'7:00PM',amount:50000,ref:'pending balance',type:'income'},
  {id:'b12',name:'Oyin i',date:'Wed May 21',time:'7:00PM',amount:3000,ref:'installment 1 of 3',type:'income'},
  {id:'b13',name:'Lumzy i',date:'Wed May 21',time:'8:00PM',amount:3000,ref:'installment 1 of 2',type:'income'},
  {id:'b14',name:'Olorunto i',date:'Thu May 22',time:'5:30PM',amount:5000,ref:'logistics update',type:'income'},
  {id:'b15',name:'Tunde i',date:'Thu May 22',time:'6:00PM',amount:10000,ref:'installment 1 of 2',type:'income'},
  {id:'b16',name:'Omale',date:'Thu May 22',time:'7:30PM',amount:1000,ref:'update reminder',type:'income'},
  {id:'b17',name:'Cousin i',date:'Thu May 22',time:'8:00PM',amount:5000,ref:'installment 1 of 2',type:'income'},
  {id:'b18',name:'Nate i',date:'Fri May 23',time:'3:00PM',amount:30000,ref:'ongoing support',type:'income'},
  {id:'b19',name:'Adejuwon',date:'Fri May 23',time:'4:00PM',amount:10000,ref:'pending balance',type:'income'},
  {id:'b20',name:'IK i',date:'Fri May 23',time:'5:00PM',amount:10000,ref:'installment 1 of 2',type:'income'},
  {id:'b21',name:'Atimoe ii',date:'Fri May 23',time:'7:00PM',amount:5000,ref:'installment 2 of 3',type:'income'},
  {id:'b22',name:'Elijah i',date:'Fri May 23',time:'9:00PM',amount:2000,ref:'installment 1 of 2',type:'income'},
  {id:'b23',name:'Olorunto ii',date:'Sat May 24',time:'3:00PM',amount:5000,ref:'logistics update',type:'income'},
  {id:'b24',name:'Basic',date:'Sat May 24',time:'4:00PM',amount:5000,ref:'logistics update',type:'income'},
  {id:'b25',name:'Larry',date:'Sat May 24',time:'5:00PM',amount:3000,ref:'support contribution',type:'income'},
  {id:'b26',name:'Bambam ii',date:'Sat May 24',time:'6:00PM',amount:2000,ref:'installment 2 of 3',type:'income'},
  {id:'b27',name:'George',date:'Sun May 25',time:'4:00PM',amount:3000,ref:'support contribution',type:'income'},
  {id:'b28',name:'Lumzy ii',date:'Sun May 25',time:'5:00PM',amount:2000,ref:'installment 2 of 2',type:'income'},
  {id:'b29',name:'Lateef i',date:'Sun May 25',time:'6:00PM',amount:3000,ref:'installment 1 of 2',type:'income'},
  {id:'b30',name:'Oyin ii',date:'Sun May 25',time:'6:30PM',amount:2000,ref:'installment 2 of 3',type:'income'},
  {id:'b31',name:'Me ii',date:'Mon May 26',time:'4:00PM',amount:20000,ref:'installment reminder',type:'income'},
  {id:'b32',name:'Emperor i',date:'Mon May 26',time:'5:30PM',amount:5000,ref:'installment 1 of 2',type:'income'},
  {id:'b33',name:'Jemil ii',date:'Mon May 26',time:'7:00PM',amount:5000,ref:'installment 2 of 2',type:'income'},
  {id:'b34',name:'Leke i',date:'Mon May 26',time:'7:00PM',amount:5000,ref:'borrowed — installment 1',type:'borrow'},
  {id:'b35',name:'Nano',date:'Tue May 27',time:'5:00PM',amount:3000,ref:'update reminder',type:'income'},
  {id:'b36',name:'Oba i',date:'Tue May 27',time:'7:00PM',amount:5000,ref:'support contribution',type:'income'},
  {id:'b37',name:'Atimoe iii',date:'Tue May 27',time:'8:00PM',amount:5000,ref:'installment 3 of 3',type:'income'},
  {id:'b38',name:'Edi i',date:'Wed May 28',time:'6:00PM',amount:10000,ref:'pending balance',type:'income'},
  {id:'b39',name:'Emmanuel',date:'Wed May 28',time:'7:30PM',amount:3000,ref:'project follow-up',type:'income'},
  {id:'b40',name:'Bambam iii',date:'Wed May 28',time:'8:00PM',amount:2000,ref:'installment 3 of 3',type:'income'},
  {id:'b41',name:'Doctor i',date:'Thu May 29',time:'4:00PM',amount:20000,ref:'project follow-up',type:'income'},
  {id:'b42',name:'Awal i',date:'Thu May 29',time:'5:00PM',amount:3000,ref:'installment 1 of 2',type:'income'},
  {id:'b43',name:'Nate ii',date:'Thu May 29',time:'6:00PM',amount:20000,ref:'update reminder',type:'income'},
  {id:'b44',name:'Tunde ii',date:'Thu May 29',time:'6:00PM',amount:10000,ref:'installment 2 of 2',type:'income'},
  {id:'b45',name:'Oyin iii',date:'Thu May 29',time:'7:00PM',amount:2000,ref:'installment 3 of 3',type:'income'},
  {id:'b46',name:'Cousin ii',date:'Thu May 29',time:'8:00PM',amount:3000,ref:'installment 2 of 2',type:'income'},
  {id:'b47',name:'Seyi i',date:'Fri May 30',time:'3:00PM',amount:50000,ref:'pending balance',type:'income'},
  {id:'b48',name:'IK ii',date:'Fri May 30',time:'5:00PM',amount:10000,ref:'installment 2 of 2',type:'income'},
  {id:'b49',name:'Elijah ii',date:'Fri May 30',time:'9:00PM',amount:2000,ref:'installment 2 of 2',type:'income'},
  {id:'b50',name:'Leke ii',date:'Sat May 31',time:'7:00PM',amount:5000,ref:'borrowed — installment 2',type:'borrow'},
  {id:'b51',name:'Oba ii',date:'Sat May 31',time:'8:00PM',amount:3000,ref:'update reminder',type:'income'},
  {id:'b52',name:'Seyi ii',date:'Fri May 30',time:'3:00PM',amount:20000,ref:'installment 2',type:'income'},
  {id:'b53',name:'Awal ii',date:'Sun Jun 1',time:'5:00PM',amount:2000,ref:'installment 2 of 2',type:'income'},
  {id:'b54',name:'Lateef ii',date:'Sun Jun 1',time:'6:00PM',amount:3000,ref:'installment 2 of 2',type:'income'},
  {id:'b55',name:'Doctor ii',date:'Thu Jun 5',time:'4:00PM',amount:10000,ref:'installment 2',type:'income'},
  {id:'b56',name:'Edi ii',date:'Wed Jun 4',time:'6:00PM',amount:5000,ref:'installment 2',type:'income'},
  {id:'b57',name:'Emperor ii',date:'Mon Jun 2',time:'5:30PM',amount:5000,ref:'installment 2 of 2',type:'income'},
  {id:'b58',name:'Lateef iii',date:'Sun Jun 1',time:'6:00PM',amount:3000,ref:'installment 3 of 3',type:'income'}
];

let buiFilter='all';

// DEFAULT APP DATA
const DEFAULT_TASKS=[
  {id:1,text:'NYSC final clearance',tag:'personal',amount:null,done:false,urgent:true,day:'Tuesday',time:'09:00'},
  {id:2,text:'Deliver 3 ready shirts to client',tag:'urgent',amount:null,done:false,urgent:true,day:'Tuesday',time:''},
  {id:3,text:'Confirm production team — client order',tag:'urgent',amount:'₦90,000',done:false,urgent:true,day:'Tuesday',time:''},
  {id:4,text:'NYSC Passing Out Parade',tag:'personal',amount:null,done:false,urgent:true,day:'Wednesday',time:''},
  {id:5,text:'Move lash bed and nail table to Lekki',tag:'personal',amount:null,done:false,urgent:false,day:'',time:''},
  {id:6,text:'Confirm Lekki space in writing',tag:'urgent',amount:null,done:false,urgent:true,day:'',time:''},
  {id:7,text:'Post Ileya teaser content — IG & Snap',tag:'content',amount:null,done:false,urgent:false,day:'Monday',time:'17:00'},
  {id:8,text:'Activate deposit payment link',tag:'client',amount:null,done:false,urgent:false,day:'Thursday',time:''},
  {id:9,text:'Transfer all received funds to PiggyVest safe lock',tag:'personal',amount:null,done:false,urgent:false,day:'',time:''},
  {id:10,text:'Production team payment',tag:'expense',amount:'₦90,000',done:false,urgent:true,day:'Wednesday',time:''},
];
const DEFAULT_LOANS=[
  {id:101,name:'Production Team',amount:'₦90,000',when:'Wednesday May 21',urgent:true},
  {id:102,name:'Dami',amount:'₦20,000',when:'Repay June 3',urgent:false},
  {id:103,name:'Leke',amount:'₦10,000',when:'TBD',urgent:false},
];
const DEFAULT_BIZ=[
  {id:1,name:'Nail Studio — Ileya Activation',target:'₦180,000',desc:'Lekki, Lagos'},
  {id:2,name:'BUI Target',target:'₦855,000',desc:'Individual contributions'},
];
const DEFAULT_SBAL=0;
const isFirstLaunch=!localStorage.getItem(SK+'_initialized');

let tasks=ld(SK+'_tasks',isFirstLaunch?DEFAULT_TASKS:[]);
let loans=ld(SK+'_loans',isFirstLaunch?DEFAULT_LOANS:[]);
let clearedLoans=ld(SK+'_cleared_loans',[]);
let biz=ld(SK+'_biz',isFirstLaunch?DEFAULT_BIZ:[{id:1,name:'Business 1',target:'₦0',desc:''}]);
let drafts=ld(SK+'_drafts',[]);
let ctas=ld(SK+'_ctas',[]);
let cfg=ld(SK+'_cfg',{autoGreet:true,morn:5,aft:12,eve:17,notif:true,autoSave:true,theme:'gold',fontSize:1});
let startingBalance=ld(SK+'_sbal',isFirstLaunch?DEFAULT_SBAL:0);

if(isFirstLaunch){sv(SK+'_tasks',tasks);sv(SK+'_loans',loans);sv(SK+'_biz',biz);sv(SK+'_sbal',startingBalance);localStorage.setItem(SK+'_initialized','1');}

let tf='all',nid=ld(SK+'_nid',200),lnid=ld(SK+'_lnid',200),lastSaved=null;
let editingTaskId=null,transactions=ld(SK+'_tx',[]),txFilter='all',txid=ld(SK+'_txid',500);
let savedContent=ld(SK+'_content',[]),cpid=ld(SK+'_cpid',1000),cpBrand='salon';
let barChart=null,pieChart=null,anaFilter='month',anaStart=null,anaEnd=null;
let calYear=new Date().getFullYear(),calMonth=new Date().getMonth();
let currentQuoteIdx=0;

const DAILY_QUOTES=[
  {text:"The grind never lies. Everything you want is on the other side of consistent work.",attr:"— Cole OS"},
  {text:"Discipline today, freedom tomorrow.",attr:"— Daily Reminder"},
  {text:"Every action you take is a vote for the person you want to become.",attr:"— James Clear"},
  {text:"The secret of getting ahead is getting started.",attr:"— Mark Twain"},
  {text:"Small consistent steps beat big inconsistent leaps.",attr:"— Cole OS"},
  {text:"Hustle in silence. Let success make the noise.",attr:"— Unknown"},
  {text:"Done is better than perfect. Start. Refine. Repeat.",attr:"— Cole OS"},
  {text:"You don't rise to the level of your goals. You fall to the level of your systems.",attr:"— James Clear"},
  {text:"What you do today shapes the version of you that shows up tomorrow.",attr:"— Cole OS"},
  {text:"Success is not final, failure is not fatal — it's the courage to continue.",attr:"— Winston Churchill"},
  {text:"It always seems impossible until it is done.",attr:"— Nelson Mandela"},
  {text:"The body achieves what the mind believes.",attr:"— Unknown"},
];
function getDailyQuote(){const d=new Date().getDate()+new Date().getMonth()*31;return DAILY_QUOTES[d%DAILY_QUOTES.length];}
function rotateQuote(){currentQuoteIdx=(currentQuoteIdx+1)%DAILY_QUOTES.length;const q=DAILY_QUOTES[currentQuoteIdx];const el=document.getElementById('hqs-quote');const at=document.getElementById('hqs-quote-attr');if(el){el.classList.remove('quote-fade');void el.offsetWidth;el.classList.add('quote-fade');el.textContent=q.text;}if(at)at.textContent=q.attr;}
function applyQuote(){const q=getDailyQuote();const el=document.getElementById('hqs-quote');const at=document.getElementById('hqs-quote-attr');if(el)el.textContent=q.text;if(at)at.textContent=q.attr;currentQuoteIdx=DAILY_QUOTES.findIndex(d=>d.text===q.text)||0;}

// SAVE
function doSave(){sv(SK+'_tasks',tasks);sv(SK+'_biz',biz);sv(SK+'_drafts',drafts);sv(SK+'_ctas',ctas);sv(SK+'_cfg',cfg);sv(SK+'_sbal',startingBalance);sv(SK+'_nid',nid);sv(SK+'_lnid',lnid);sv(SK+'_loans',loans);sv(SK+'_cleared_loans',clearedLoans);sv(SK+'_tx',transactions);sv(SK+'_txid',txid);sv(SK+'_content',savedContent);sv(SK+'_cpid',cpid);lastSaved=new Date();sv(SK+'_lastsaved',lastSaved.toISOString());showSaveIndicator();updateSaveStatusText();}
function triggerAutoSave(){if(cfg.autoSave)doSave();}
function manualSave(){doSave();showNotif('All data saved successfully','success');}
function showSaveIndicator(){const el=document.getElementById('save-indicator');if(!el)return;el.classList.add('show');setTimeout(()=>el.classList.remove('show'),1500);}
function updateSaveStatusText(){const el=document.getElementById('save-status-text');if(!el)return;el.textContent=lastSaved?'Last saved: '+lastSaved.toLocaleTimeString([],{hour:'2-digit',minute:'2-digit',second:'2-digit'}):'Last saved: not yet';}
function toggleAutoSave(){cfg.autoSave=!cfg.autoSave;document.getElementById('autosave-tog').classList.toggle('on',cfg.autoSave);sv(SK+'_cfg',cfg);}
function resetAllData(){if(!confirm('Reset ALL data? This cannot be undone.'))return;const keys=[SK+'_tasks',SK+'_biz',SK+'_drafts',SK+'_ctas',SK+'_cfg',SK+'_sbal',SK+'_nid',SK+'_lnid',SK+'_loans',SK+'_cleared_loans',SK+'_tx',SK+'_txid',SK+'_content',SK+'_cpid',SK+'_lastsaved',SK+'_initialized'];keys.forEach(k=>localStorage.removeItem(k));showNotif('App reset. Reloading...','info',2000);setTimeout(()=>window.location.reload(),1500);}

// NOTIF
function showNotif(msg,type,dur){dur=dur||4000;const bar=document.getElementById('notif-bar');const cols={urgent:'#e05252',income:'#5cb85c',expense:'#e05252',info:'#d4a843',success:'#5cb85c'};const el=document.createElement('div');el.className='ntitem';el.innerHTML='<div class="ntdot" style="background:'+(cols[type]||cols.info)+'"></div><div class="nttxt">'+msg+'</div><div class="ntclose" onclick="this.parentElement.remove()">×</div>';bar.appendChild(el);setTimeout(()=>{if(el.parentElement)el.remove();},dur);}
function triggerTestNotif(){showNotif('Test notification working','info',4000);}
function toggleNotif(){cfg.notif=!cfg.notif;document.getElementById('notif-tog').classList.toggle('on',cfg.notif);sv(SK+'_cfg',cfg);}

// THEME
function setTheme(t){cfg.theme=t;sv(SK+'_cfg',cfg);applyTheme();}
function applyTheme(){['theme-light','theme-dark','theme-chatgpt'].forEach(c=>document.body.classList.remove(c));if(cfg.theme==='light')document.body.classList.add('theme-light');else if(cfg.theme==='dark')document.body.classList.add('theme-dark');else if(cfg.theme==='chatgpt')document.body.classList.add('theme-chatgpt');document.querySelectorAll('.theme-btn').forEach(b=>b.classList.remove('active'));const ab=document.getElementById('btn-theme-'+(cfg.theme||'gold'));if(ab)ab.classList.add('active');}
function setFontSize(val){cfg.fontSize=parseInt(val);sv(SK+'_cfg',cfg);['fs-sm','fs-md','fs-lg','fs-xl'].forEach(c=>document.body.classList.remove(c));document.body.classList.add(['fs-sm','fs-md','fs-lg','fs-xl'][cfg.fontSize||1]);const pr=document.getElementById('fs-preview');if(pr)pr.textContent=['Small','Medium','Large','XL'][cfg.fontSize||1];const sl=document.getElementById('fs-slider');if(sl)sl.value=cfg.fontSize||1;}

// GREETING
function applyGreeting(){const h=new Date().getHours();let greet='Good evening, Gbemi 🌙';if(h>=(cfg.morn||5)&&h<(cfg.aft||12))greet='Good morning, Gbemi 👑';else if(h>=(cfg.aft||12)&&h<(cfg.eve||17))greet='Good afternoon, Gbemi ✨';const el=document.getElementById('home-greet');if(el)el.textContent=greet;}
function toggleAutoGreet(){cfg.autoGreet=!cfg.autoGreet;document.getElementById('greet-tog').classList.toggle('on',cfg.autoGreet);sv(SK+'_cfg',cfg);}
function applyDate(){const d=new Date();const days=['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];const months=['January','February','March','April','May','June','July','August','September','October','November','December'];const el=document.getElementById('home-date-lbl');if(el)el.textContent=days[d.getDay()]+', '+d.getDate()+' '+months[d.getMonth()]+' '+d.getFullYear();}

// PWA
let deferredPrompt=null;
window.addEventListener('beforeinstallprompt',e=>{e.preventDefault();deferredPrompt=e;const b=document.getElementById('pwa-banner');if(b)b.classList.add('show');});
document.getElementById('pwa-install-btn').addEventListener('click',async()=>{if(deferredPrompt){deferredPrompt.prompt();const{outcome}=await deferredPrompt.userChoice;deferredPrompt=null;dismissPWA();}else{showNotif('To install: tap Share → Add to Home Screen (iOS) or browser menu → Install','info',6000);}});
function dismissPWA(){const b=document.getElementById('pwa-banner');if(b)b.classList.remove('show');}
setTimeout(()=>{const isIOS=/iphone|ipad|ipod/i.test(navigator.userAgent);const isInStandalone=window.navigator.standalone;if(isIOS&&!isInStandalone&&!localStorage.getItem('pwa_dismissed')){const b=document.getElementById('pwa-banner');if(b){b.querySelector('.pwa-txt').innerHTML='<strong>ADD TO HOME SCREEN</strong>Tap Share → "Add to Home Screen" to install COLE OS';b.classList.add('show');}}},3000);
window.dismissPWA=function(){localStorage.setItem('pwa_dismissed','1');const b=document.getElementById('pwa-banner');if(b)b.classList.remove('show');};

// NAV
function openMenu(){document.getElementById('menu-overlay').classList.add('open');document.getElementById('menu-drawer').classList.add('open');}
function closeMenu(){document.getElementById('menu-overlay').classList.remove('open');document.getElementById('menu-drawer').classList.remove('open');}
function openCat(cat){closeMenu();document.querySelectorAll('.cat-overlay').forEach(el=>el.classList.remove('open'));const el=document.getElementById('cat-'+cat);if(el)el.classList.add('open');}
function closeCat(cat){const el=document.getElementById('cat-'+cat);if(el)el.classList.remove('open');}
function openSec(id){
  document.querySelectorAll('.sec-page').forEach(el=>el.classList.remove('open'));
  document.querySelectorAll('.cat-overlay').forEach(el=>el.classList.remove('open'));
  const el=document.getElementById('sec-'+id);if(!el)return;
  el.classList.add('open');
  if(id==='tasks'){renderTasks();renderPriorities();}
  if(id==='bui'){renderBUI();}
  if(id==='dashboard'){renderDashboard();renderBiz();}
  if(id==='money')renderMoneyPage();
  if(id==='analytics')renderAnalytics();
  if(id==='finance')renderTxList();
  if(id==='calendar')renderCalendar();
  if(id==='content')renderSavedContent();
  if(id==='week')renderWeekPlan();
  if(id==='credits'){renderCredits();renderClearedAnalysis();}
  if(id==='drafts')renderDrafts();
  if(id==='cta')renderCtas();
  if(id==='settings'){loadCfgUI();renderBizSettings();}
}
function closeSec(id){const el=document.getElementById('sec-'+id);if(el)el.classList.remove('open');}

// SEARCH
function doSearch(q){const el=document.getElementById('search-results');if(!el)return;if(!q||q.trim().length<2){el.style.display='none';return;}const term=q.toLowerCase().trim();const results=[];tasks.forEach(t=>{if(t.text.toLowerCase().includes(term))results.push({icon:'✓',bg:'rgba(212,168,67,.12)',col:'var(--accent)',title:t.text,sub:(t.done?'Done':'Pending')+(t.amount?' · '+t.amount:''),go:()=>{closeCat('tasks');openSec('tasks');}});});BUI_DATA.forEach(e=>{if(e.name.toLowerCase().includes(term))results.push({icon:'₦',bg:'rgba(92,184,92,.12)',col:'var(--green)',title:e.name,sub:e.ref+' · ₦'+e.amount.toLocaleString(),go:()=>openSec('bui')});});transactions.forEach(t=>{if(t.desc.toLowerCase().includes(term))results.push({icon:t.type==='income'?'IN':'OUT',bg:t.type==='income'?'rgba(92,184,92,.12)':'rgba(224,82,82,.12)',col:t.type==='income'?'var(--green)':'var(--red)',title:t.desc,sub:'₦'+t.amount.toLocaleString(),go:()=>openSec('finance')});});loans.forEach(l=>{if(l.name.toLowerCase().includes(term))results.push({icon:'₦',bg:'rgba(224,82,82,.12)',col:'var(--red)',title:l.name,sub:l.amount+' · '+l.when,go:()=>openSec('credits')});});if(!results.length){el.innerHTML='<div style="padding:14px 16px;color:var(--muted);font-size:12px;text-align:center">No results found</div>';el.style.display='block';return;}window._sr=results;el.innerHTML=results.slice(0,7).map((r,i)=>`<div onclick="srClick(${i})" style="display:flex;align-items:center;gap:10px;padding:11px 14px;border-bottom:1px solid var(--border);cursor:pointer;background:var(--card)"><div style="width:30px;height:30px;border-radius:8px;background:${r.bg};color:${r.col};display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:700;flex-shrink:0">${r.icon}</div><div style="flex:1;min-width:0"><div style="font-size:12px;font-weight:600;color:var(--text);white-space:nowrap;overflow:hidden;text-overflow:ellipsis">${r.title}</div><div style="font-size:10px;color:var(--muted);margin-top:1px">${r.sub}</div></div></div>`).join('');el.style.display='block';}
function srClick(i){document.getElementById('search-input').value='';document.getElementById('search-results').style.display='none';const r=window._sr&&window._sr[i];if(r&&r.go)r.go();}
document.addEventListener('click',e=>{if(!e.target.closest('.search-wrap')){const sr=document.getElementById('search-results');if(sr)sr.style.display='none';}});

// ═══════════════════ BUI RENDER ═══════════════════
function getBUIState(id){return ld(SK+'_bui_'+id,false);}
function setBUIState(id,val){sv(SK+'_bui_'+id,val);}

function renderBUI(){
  const list=document.getElementById('bui-list');if(!list)return;
  let expected=0,received=0;
  BUI_DATA.forEach(e=>{if(e.type!=='borrow'&&e.amount){expected+=e.amount;if(getBUIState(e.id))received+=e.amount;}});
  const pending=expected-received;
  const eEl=document.getElementById('bui-expected');const rEl=document.getElementById('bui-received');const pEl=document.getElementById('bui-pending');
  if(eEl)eEl.textContent=fmt(expected);if(rEl)rEl.textContent=fmt(received);if(pEl)pEl.textContent=fmt(pending);

  const groups={};
  BUI_DATA.forEach(e=>{
    const done=getBUIState(e.id);
    if(buiFilter==='pending'&&done)return;
    if(buiFilter==='done'&&!done)return;
    if(buiFilter==='borrow'&&e.type!=='borrow')return;
    if(!groups[e.date])groups[e.date]=[];
    groups[e.date].push(e);
  });

  let html='';
  Object.keys(groups).forEach(date=>{
    html+=`<div class="bui-day-label">${date}</div>`;
    groups[date].forEach(e=>{
      const done=getBUIState(e.id);
      const typeClass=e.type==='borrow'?'bui-borrow':done?'bui-done':'bui-pending';
      const tagLabel=e.type==='borrow'?'Borrow':done?'Received':'Pending';
      const tagClass=e.type==='borrow'?'bui-tag-borrow':done?'bui-tag-income':'bui-tag-pending';
      html+=`<div class="bui-entry ${typeClass}" onclick="toggleBUIEntry('${e.id}')">
        <div class="bui-check ${done?'checked':''}"></div>
        <div class="bui-info">
          <div class="bui-name">${e.name}</div>
          <div class="bui-ref">${e.ref}</div>
          <div class="bui-time">${e.time}</div>
        </div>
        <div class="bui-right">
          <div class="bui-amt">${e.amount?fmt(e.amount):'TBD'}</div>
          <span class="bui-tag ${tagClass}">${tagLabel}</span>
        </div>
      </div>`;
    });
  });
  if(!html)html='<div style="padding:24px;text-align:center;color:var(--muted);font-size:12px;font-style:italic">No entries in this filter</div>';
  list.innerHTML=html;
}

function toggleBUIEntry(id){
  const current=getBUIState(id);
  setBUIState(id,!current);
  renderBUI();
  showNotif(current?'Marked pending':'Received ✓ — Transfer to PiggyVest','success');
}

function filterBUI(f,el){
  buiFilter=f;
  document.querySelectorAll('#sec-bui .chip').forEach(c=>c.classList.remove('active'));
  if(el)el.classList.add('active');
  renderBUI();
}

// FINANCE
function calcFinance(){const cp=tasks.filter(t=>t.tag==='client'&&!t.done&&t.amount);const cd=tasks.filter(t=>t.tag==='client'&&t.done&&t.amount);const ep=tasks.filter(t=>t.tag==='expense'&&!t.done&&t.amount);const ed=tasks.filter(t=>t.tag==='expense'&&t.done&&t.amount);return{expectedIn:cp.reduce((s,t)=>s+parseAmt(t.amount),0),moneyIn:cd.reduce((s,t)=>s+parseAmt(t.amount),0),totalBills:ep.reduce((s,t)=>s+parseAmt(t.amount),0),moneyOut:ed.reduce((s,t)=>s+parseAmt(t.amount),0),balance:startingBalance+cd.reduce((s,t)=>s+parseAmt(t.amount),0)-ed.reduce((s,t)=>s+parseAmt(t.amount),0),clientPending:cp,clientDone:cd,expensePending:ep,expenseDone:ed};}
function updateHomeStats(){const fin=calcFinance();const pending=tasks.filter(t=>!t.done).length;const b=document.getElementById('hqs-balance');if(b){b.textContent=fmt(fin.balance);b.style.color=fin.balance>=0?'var(--green)':'var(--red)';}const t2=document.getElementById('hqs-tasks');if(t2)t2.textContent=pending;const mi=document.getElementById('hqs-in');if(mi)mi.textContent=fmt(fin.moneyIn);const mo=document.getElementById('hqs-out');if(mo)mo.textContent=fmt(fin.moneyOut);const cs=document.getElementById('hmc-tasks-sub');if(cs)cs.textContent=pending+' pending';const cf=document.getElementById('hmc-finance-sub');if(cf)cf.textContent=fmt(fin.balance);}
function saveStartingBalance(){const inp=document.getElementById('sbal-input');const val=parseAmt(inp.value)||0;startingBalance=val;triggerAutoSave();inp.value=val>0?fmt(val):'';document.getElementById('sbal-note').textContent='Balance set: '+fmt(val);renderMoneyPage();renderDashboard();updateHomeStats();showNotif('Balance updated to '+fmt(val),'info');}

// PRIORITIES
function renderPriorities(){const el=document.getElementById('pri-list');if(!el)return;const pris=tasks.filter(t=>!t.done&&(t.urgent||t.tag==='client'||t.tag==='expense')).slice(0,6);if(!pris.length){el.innerHTML='<div style="padding:4px 18px 16px;color:var(--muted);font-size:12px;font-style:italic">All priorities cleared — great work!</div>';return;}const dotColor={urgent:'var(--red)',client:'var(--green)',expense:'var(--accent)',personal:'var(--blue)',content:'var(--blue)'};el.innerHTML=pris.map(t=>`<div class="pri-item" onclick="tickPriority(${t.id})"><div class="pri-dot" style="background:${dotColor[t.tag]||'var(--muted)'}"></div><div class="pri-txt">${t.text}${t.amount?'<span style="color:var(--muted);font-size:10px;font-family:DM Mono,monospace;margin-left:6px">('+t.amount+')</span>':''}</div><div class="pri-check"></div></div>`).join('');}
function tickPriority(id){const t=tasks.find(t=>t.id===id);if(!t)return;t.done=true;triggerAutoSave();if(t.amount){if(t.tag==='client')showNotif('Payment received: '+t.text.slice(0,35)+' — '+t.amount,'income');else if(t.tag==='expense')showNotif('Expense paid: '+t.text.slice(0,35)+' — '+t.amount,'expense');}else showNotif('Done: '+t.text.slice(0,45),'success');renderPriorities();renderTasks();renderMoneyPage();renderDashboard();updateHomeStats();}

// TASKS
function renderTasks(){const c=document.getElementById('task-container');let filtered=tf==='all'?tasks:tf==='urgent'?tasks.filter(t=>t.urgent||t.tag==='urgent'):tasks.filter(t=>t.tag===tf);const pend=filtered.filter(t=>!t.done),done=filtered.filter(t=>t.done);let h='';if(pend.length){h+='<div class="tgl">Pending — '+pend.length+'</div>';pend.forEach(t=>h+=tHTML(t));}if(done.length){h+='<div class="tgl">Completed — '+done.length+'</div>';done.forEach(t=>h+=tHTML(t));}if(!filtered.length)h='<div style="text-align:center;padding:40px;color:var(--muted);font-size:12px;letter-spacing:2px">NO TASKS YET</div>';c.innerHTML=h;updateStats();}
function tHTML(t){const amtCls=t.tag==='client'?'tamt in':t.tag==='expense'?'tamt out':'tamt';const amtPfx=t.tag==='client'?'+ ':t.tag==='expense'?'- ':'';const txtCls='tt'+(t.done?' done':'')+(t.urgent&&!t.done?' urg':'');const meta=[];if(t.day)meta.push(t.day);if(t.time)meta.push(t.time);return`<div class="trow"><div class="tck${t.done?' done':''}" onclick="toggleTask(${t.id})">${t.done?'<span style="color:#000;font-size:11px;font-weight:700">✓</span>':''}</div><div class="tb"><div class="${txtCls}" onclick="toggleTask(${t.id})">${t.text}</div><div class="tmeta">${t.amount?`<span class="${amtCls}">${amtPfx}${t.amount}</span>`:''} ${meta.length?`<span class="tdaytime">${meta.join(' · ')}</span>`:''}</div></div>${t.urgent&&!t.done?'<div class="rdot"></div>':''}<div class="task-actions"><button class="task-action-btn" onclick="openEditModal(${t.id})" title="Edit">✏</button><button class="task-action-btn" onclick="delTask(${t.id})" title="Delete">×</button></div></div>`;}
function toggleTask(id){const t=tasks.find(t=>t.id===id);if(!t)return;t.done=!t.done;triggerAutoSave();if(t.done&&t.amount){if(t.tag==='client')showNotif('Payment received: '+t.text.slice(0,35)+' — '+t.amount,'income');else if(t.tag==='expense')showNotif('Expense paid: '+t.text.slice(0,35)+' — '+t.amount,'expense');}renderTasks();renderPriorities();renderMoneyPage();renderDashboard();updateHomeStats();}
function delTask(id){tasks=tasks.filter(t=>t.id!==id);triggerAutoSave();renderTasks();renderPriorities();renderMoneyPage();renderDashboard();updateHomeStats();}
function addTask(){const i=document.getElementById('t-in'),ts=document.getElementById('t-tag'),ai=document.getElementById('t-amt');const td=document.getElementById('t-day'),tt=document.getElementById('t-time');const txt=i.value.trim();if(!txt)return;const tag=ts.value,amt=ai.value.trim()||null,urg=tag==='urgent';tasks.push({id:nid++,text:txt,tag,amount:amt,done:false,urgent:urg,day:td.value,time:tt.value});triggerAutoSave();i.value='';ai.value='';td.value='';tt.value='';if(urg&&cfg.notif)showNotif('Urgent task added: '+txt.slice(0,40),'urgent');renderTasks();renderPriorities();renderMoneyPage();renderDashboard();updateHomeStats();}
function filterT(f,el){tf=f;document.querySelectorAll('.chip').forEach(c=>c.classList.remove('active'));el.classList.add('active');renderTasks();}
function openEditModal(id){const t=tasks.find(t=>t.id===id);if(!t)return;editingTaskId=id;document.getElementById('edit-task-text').value=t.text;document.getElementById('edit-task-amount').value=t.amount||'';document.getElementById('edit-task-day').value=t.day||'';document.getElementById('edit-task-time').value=t.time||'';document.getElementById('edit-task-tag').value=t.tag||'personal';document.getElementById('editModal').classList.add('open');}
function closeEditModal(){editingTaskId=null;document.getElementById('editModal').classList.remove('open');}
function saveTaskEdit(){if(!editingTaskId)return;const t=tasks.find(t=>t.id===editingTaskId);if(!t)return;t.text=document.getElementById('edit-task-text').value.trim()||t.text;t.amount=document.getElementById('edit-task-amount').value.trim()||null;t.day=document.getElementById('edit-task-day').value;t.time=document.getElementById('edit-task-time').value;t.tag=document.getElementById('edit-task-tag').value;t.urgent=t.tag==='urgent';triggerAutoSave();closeEditModal();renderTasks();renderPriorities();renderMoneyPage();renderDashboard();updateHomeStats();showNotif('Task updated','success');}
document.getElementById('editModal').addEventListener('click',function(e){if(e.target===this)closeEditModal();});
function updateStats(){const tot=tasks.length,done=tasks.filter(t=>t.done).length,pct=tot?Math.round((done/tot)*100):0;const tf2=document.getElementById('t-prog');if(tf2)tf2.style.width=pct+'%';const tpl=document.getElementById('t-pl');if(tpl)tpl.textContent=done+' done';const tpp=document.getElementById('t-pp');if(tpp)tpp.textContent=pct+'%';const th=document.getElementById('t-header');if(th)th.textContent=done+'/'+tot+' done';const dt=document.getElementById('d-total');if(dt)dt.textContent=tot;const ld2=document.getElementById('leg-done');if(ld2)ld2.textContent=done+' Completed';const lp=document.getElementById('leg-pend');if(lp)lp.textContent=(tot-done)+' Pending';const lc=document.getElementById('leg-client');if(lc)lc.textContent=tasks.filter(t=>t.tag==='client'&&!t.done).length+' Client tasks';const le=document.getElementById('leg-expense');if(le)le.textContent=tasks.filter(t=>t.tag==='expense'&&!t.done).length+' Expense tasks';const circ=2*Math.PI*35,filled=tot?(done/tot)*circ:0;const dd=document.getElementById('d-done');if(dd)dd.setAttribute('stroke-dasharray',filled+' '+(circ-filled));}

// WEEK PLAN
function renderWeekPlan(){const c=document.getElementById('week-container');const wt=tasks.filter(t=>t.day&&WEEKDAYS.includes(t.day));if(!wt.length){c.innerHTML='<div class="card" style="margin:0 16px"><div style="text-align:center;padding:20px;color:var(--muted);font-size:12px">No tasks assigned to days yet.</div></div>';return;}c.innerHTML=WEEKDAYS.map(day=>{const dt=wt.filter(t=>t.day===day);if(!dt.length)return'';const sorted=[...dt].sort((a,b)=>{if(!a.time&&!b.time)return 0;if(!a.time)return 1;if(!b.time)return-1;return a.time.localeCompare(b.time);});return`<div class="week-day"><div class="week-hdr">${day}</div><div class="week-card">${sorted.map(t=>`<div class="week-row">${t.urgent?'<div class="week-dot"></div>':''}<div class="week-time">${t.time||'--'}</div><div class="week-txt${t.done?' done':''}">${t.text}${t.amount?`<span style="color:var(--muted);font-size:9px;font-family:'DM Mono',monospace;margin-left:6px">${t.tag==='client'?'+ ':t.tag==='expense'?'- ':''}${t.amount}</span>`:''}</div></div>`).join('')}</div></div>`;}).join('');}

// MONEY PAGE
function renderMoneyPage(){const fin=calcFinance();const mb=document.getElementById('m-balance');if(mb){mb.textContent=fmt(fin.balance);mb.style.color=fin.balance>=0?'var(--green)':'var(--red)';}const mmi=document.getElementById('m-moneyin');if(mmi)mmi.textContent=fmt(fin.moneyIn);const mmo=document.getElementById('m-moneyout');if(mmo)mmo.textContent=fmt(fin.moneyOut);const si=document.getElementById('sbal-input');if(si&&startingBalance>0)si.value=fmt(startingBalance);document.getElementById('sbal-note').textContent='Current balance: '+fmt(fin.balance);const pc=document.getElementById('m-pending-clients'),et=document.getElementById('m-expected-total');if(et)et.textContent=fin.clientPending.length>0?'Expected: '+fmt(fin.expectedIn):'';if(pc){if(!fin.clientPending.length)pc.innerHTML='<div style="color:var(--muted);font-size:12px;text-align:center;padding:12px">No pending client payments</div>';else pc.innerHTML=fin.clientPending.map(t=>`<div class="payi"><div class="payico" style="background:rgba(92,184,92,.1);color:var(--green)">IN</div><div style="flex:1"><div class="payn">${t.text}</div><div class="payd">${t.urgent?'🔴 Urgent':'Pending'}</div></div><div style="text-align:right"><div class="paya in">${t.amount}</div><div class="pb pb-g">Expected</div></div></div>`).join('');}const pe=document.getElementById('m-pending-expenses'),bt2=document.getElementById('m-bills-total');if(bt2)bt2.textContent=fin.expensePending.length>0?'Total: '+fmt(fin.totalBills):'';if(pe){if(!fin.expensePending.length)pe.innerHTML='<div style="color:var(--muted);font-size:12px;text-align:center;padding:12px">No pending expenses</div>';else pe.innerHTML=fin.expensePending.map(t=>`<div class="payi"><div class="payico" style="background:rgba(224,82,82,.1);color:var(--red)">OUT</div><div style="flex:1"><div class="payn">${t.text}</div><div class="payd">${t.urgent?'🔴 Urgent':'Pending'}</div></div><div style="text-align:right"><div class="paya out">${t.amount}</div><div class="pb pb-r">Bill</div></div></div>`).join('');}const mr=document.getElementById('m-received');if(mr){if(!fin.clientDone.length)mr.innerHTML='<div style="color:var(--muted);font-size:12px;text-align:center;padding:12px">No received payments yet</div>';else mr.innerHTML=fin.clientDone.map(t=>`<div class="txr"><div class="tx-ico in">IN</div><div style="flex:1"><div class="tx-name">${t.text}</div><div class="tx-tag">CLIENT - RECEIVED</div></div><div class="tx-amt in">+${t.amount}</div></div>`).join('');}const mpd=document.getElementById('m-paid');if(mpd){if(!fin.expenseDone.length)mpd.innerHTML='<div style="color:var(--muted);font-size:12px;text-align:center;padding:12px">No paid expenses yet</div>';else mpd.innerHTML=fin.expenseDone.map(t=>`<div class="txr"><div class="tx-ico out">OUT</div><div style="flex:1"><div class="tx-name">${t.text}</div><div class="tx-tag">EXPENSE - PAID</div></div><div class="tx-amt out">-${t.amount}</div></div>`).join('');}renderLoansInMoney();}
function renderLoansInMoney(){const el=document.getElementById('loans-list');if(!el)return;if(!loans.length){el.innerHTML='<div style="color:var(--muted);font-size:12px;text-align:center;padding:12px">No standing credit</div>';return;}el.innerHTML=loans.map((l,i)=>`<div class="loan-row"><div style="font-size:9px;color:${l.urgent?'var(--red)':'var(--muted)'};font-family:'DM Mono',monospace;width:20px;flex-shrink:0;font-weight:600">0${i+1}</div><div class="loan-name">${l.name}</div><div style="text-align:right"><div class="loan-amt" style="color:${l.urgent?'var(--red)':'var(--muted)'}">${l.amount}</div><div class="loan-when">${l.when}</div></div></div>`).join('');}

// DASHBOARD
function renderDashboard(){const fin=calcFinance();const db=document.getElementById('dash-balance');if(db){db.textContent=fmt(fin.balance);db.style.color='#000';}const dbs=document.getElementById('dash-bal-sub');if(dbs)dbs.textContent='Start '+fmt(startingBalance)+' — In '+fmt(fin.moneyIn)+' — Out '+fmt(fin.moneyOut);const dmi=document.getElementById('dash-moneyin');if(dmi)dmi.textContent=fmt(fin.moneyIn);const dmis=document.getElementById('dash-moneyin-sub');if(dmis)dmis.textContent=fin.clientDone.length+' received';const dmo=document.getElementById('dash-moneyout');if(dmo)dmo.textContent=fmt(fin.moneyOut);const dmos=document.getElementById('dash-moneyout-sub');if(dmos)dmos.textContent=fin.expenseDone.length+' paid';const de=document.getElementById('dash-expected');if(de)de.textContent=fmt(fin.expectedIn);const des=document.getElementById('dash-expected-sub');if(des)des.textContent=fin.clientPending.length+' pending';const dbl=document.getElementById('dash-bills');if(dbl)dbl.textContent=fmt(fin.totalBills);const dbls=document.getElementById('dash-bills-sub');if(dbls)dbls.textContent=fin.expensePending.length+' expenses';const txEl=document.getElementById('dash-tx-list');if(txEl){const allDone=[...fin.clientDone.map(t=>({...t,dir:'in'})),...fin.expenseDone.map(t=>({...t,dir:'out'}))];if(!allDone.length)txEl.innerHTML='<div style="color:var(--muted);font-size:12px;text-align:center;padding:12px">Complete tasks to see transactions</div>';else txEl.innerHTML=allDone.map(t=>`<div class="txr"><div class="tx-ico ${t.dir}">${t.dir==='in'?'IN':'OUT'}</div><div style="flex:1"><div class="tx-name">${t.text}</div><div class="tx-tag">${t.dir==='in'?'CLIENT - RECEIVED':'EXPENSE - PAID'}</div></div><div class="tx-amt ${t.dir}">${t.dir==='in'?'+':'-'}${t.amount}</div></div>`).join('');}updateStats();}
function renderBiz(){const db=document.getElementById('dash-biz');if(db)db.innerHTML=biz.map(b=>`<div class="bizcard"><div class="bizlogo" style="background:var(--card2);font-family:'Bebas Neue',sans-serif;font-size:11px;color:var(--accent);letter-spacing:1px">${b.name.slice(0,3).toUpperCase()}</div><div class="bizname">${b.name}</div><div style="font-size:8px;color:var(--muted);margin-bottom:2px;font-family:'DM Mono',monospace">TARGET</div><div class="bizval">${b.target}</div></div>`).join('');}
function renderBizSettings(){const el=document.getElementById('biz-settings-list');if(!el)return;if(!biz.length){el.innerHTML='<div style="color:var(--muted);font-size:12px;text-align:center;padding:12px">No businesses</div>';return;}el.innerHTML=biz.map(b=>`<div style="display:flex;align-items:center;gap:10px;padding:12px 0;border-bottom:1px solid var(--border)"><div style="flex:1;font-size:14px;color:var(--text);font-weight:500">${b.name}</div><input value="${b.target}" onchange="updBiz(${b.id},this.value)" style="width:100px;font-size:12px;padding:6px 9px;margin:0"><button onclick="delBiz(${b.id})" style="background:none;border:none;font-size:16px;cursor:pointer;color:var(--muted)">×</button></div>`).join('');}
function updBiz(id,val){const b=biz.find(b=>b.id===id);if(b){b.target=val;triggerAutoSave();}}
function delBiz(id){biz=biz.filter(b=>b.id!==id);triggerAutoSave();renderBizSettings();}
function addBiz(){const n=prompt('Business name:');if(!n)return;const t=prompt('Target:')||'₦0';biz.push({id:Date.now(),name:n,target:t,desc:''});triggerAutoSave();renderBizSettings();renderBiz();}

// CREDITS
function renderCredits(){const el=document.getElementById('credits-list');if(!el)return;if(!loans.length){el.innerHTML='<div style="color:var(--muted);font-size:12px;text-align:center;padding:12px">No standing credit entries</div>';return;}el.innerHTML=loans.map((l,i)=>`<div class="loan-row"><button class="loan-clear-btn" onclick="clearLoan(${l.id})" title="Mark cleared" style="border-color:${l.urgent?'var(--red)':'var(--muted2)'}"><svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg></button><div class="loan-name">${l.name}</div><div style="text-align:right"><div class="loan-amt" style="color:${l.urgent?'var(--red)':'var(--muted)'}">${l.amount}</div><div class="loan-when">${l.when}</div></div><button style="background:none;border:none;font-size:16px;cursor:pointer;padding:2px 4px;color:var(--muted);flex-shrink:0" onclick="deleteLoan(${l.id})">×</button></div>`).join('');}
function clearLoan(id){const l=loans.find(l=>l.id===id);if(!l)return;const now=new Date();clearedLoans.push({id:Date.now(),name:l.name,amount:l.amount,when:l.when,clearedDate:now.toLocaleDateString([],{day:'numeric',month:'short',year:'numeric'}),clearedMonth:now.getMonth(),clearedYear:now.getFullYear()});loans=loans.filter(l=>l.id!==id);triggerAutoSave();showNotif(l.name+' — '+l.amount+' cleared','success');renderCredits();renderClearedAnalysis();renderLoansInMoney();}
function deleteLoan(id){loans=loans.filter(l=>l.id!==id);triggerAutoSave();renderCredits();renderLoansInMoney();}
function addLoanPrompt(){const n=prompt('Who do you owe:');if(!n)return;const a=prompt('Amount (e.g. ₦10,000):');if(!a)return;const w=prompt('When due:')||'ASAP';const u=confirm('Is this urgent?');loans.push({id:lnid++,name:n,amount:a,when:w,urgent:u});triggerAutoSave();renderCredits();renderLoansInMoney();}
function renderClearedAnalysis(){const el=document.getElementById('cleared-analysis');if(!el)return;if(!clearedLoans.length){el.innerHTML='<div style="padding:0 16px 12px;color:var(--muted);font-size:12px;font-style:italic">No cleared credit yet.</div>';return;}const groups={};clearedLoans.forEach(c=>{const key=c.clearedYear+'-'+c.clearedMonth;if(!groups[key])groups[key]={label:MONTHS_AR[c.clearedMonth]+' '+c.clearedYear,items:[],total:0};groups[key].items.push(c);groups[key].total+=parseAmt(c.amount);});const sortedKeys=Object.keys(groups).sort((a,b)=>b.localeCompare(a));el.innerHTML=sortedKeys.map(key=>{const g=groups[key];return`<div class="card" style="margin-top:8px"><div class="ct" style="display:flex;justify-content:space-between;align-items:center"><span>${g.label}</span><span style="color:var(--green);font-family:'DM Mono',monospace;font-size:12px">${fmt(g.total)} cleared</span></div>${g.items.map(c=>`<div class="analysis-row"><div><div class="analysis-name">${c.name}</div><div class="analysis-meta">Cleared ${c.clearedDate}</div></div><div class="analysis-amt">${c.amount}</div></div>`).join('')}</div>`;}).join('');}

// DRAFTS — FULL MESSAGING FEATURE
function renderDrafts(){
  const el=document.getElementById('drafts-list');
  if(!el)return;
  if(!drafts.length){el.innerHTML='<div style="padding:0 16px 12px;color:var(--muted);font-size:12px;font-style:italic">No draft messages yet. Tap + New Draft to add one.</div>';return;}
  el.innerHTML=drafts.map(d=>`
    <div class="dc2">
      <div class="dto">To</div>
      <div class="dn2">
        <input value="${d.name||''}" placeholder="Recipient name" onchange="updateDraftName(${d.id},this.value)" style="background:none;border:none;border-bottom:1px solid var(--border);border-radius:0;padding:4px 0;font-size:14px;font-weight:700;color:var(--accent);font-family:'DM Sans',sans-serif;width:100%;outline:none;">
        <button style="background:none;border:1.5px solid var(--border);border-radius:6px;padding:4px 10px;font-size:11px;cursor:pointer;color:var(--muted);flex-shrink:0;margin-left:8px" onclick="delDraft(${d.id})">Remove</button>
      </div>
      <textarea class="dea" placeholder="Type your message here..." onchange="saveDraftBody(${d.id},this.value)">${d.body||''}</textarea>
      <div class="dtag" style="margin-top:8px">
        <input value="${d.timing||''}" placeholder="Add timing note (e.g. Send Mon 7PM)" onchange="updateDraftTiming(${d.id},this.value)" style="background:none;border:none;border-bottom:1px dashed var(--border);border-radius:0;padding:3px 0;font-size:10px;color:var(--muted);font-family:'DM Mono',monospace;width:100%;outline:none;">
      </div>
    </div>`).join('');
}
function addDraft(){const n=prompt('Recipient name:');if(!n)return;drafts.push({id:Date.now(),name:n,body:'',timing:''});triggerAutoSave();renderDrafts();}
function saveDraftBody(id,v){const d=drafts.find(d=>d.id===id);if(d){d.body=v;triggerAutoSave();}}
function updateDraftName(id,v){const d=drafts.find(d=>d.id===id);if(d){d.name=v;triggerAutoSave();}}
function updateDraftTiming(id,v){const d=drafts.find(d=>d.id===id);if(d){d.timing=v;triggerAutoSave();}}
function delDraft(id){drafts=drafts.filter(d=>d.id!==id);triggerAutoSave();renderDrafts();}

// CTA
function renderCtas(){const el=document.getElementById('cta-list');if(!el)return;if(!ctas.length){el.innerHTML='<div style="padding:0 16px 12px;color:var(--muted);font-size:12px;font-style:italic">No actions yet</div>';return;}el.innerHTML=ctas.map(c=>`<div class="cc"><div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:4px"><div><div class="cday">${c.day}</div><div class="ctime2">${c.time}</div></div><button style="background:none;border:none;font-size:18px;cursor:pointer;padding:2px 4px;color:var(--muted)" onclick="delCta(${c.id})">×</button></div><div class="cact">${c.action}</div><div class="cnote2">${c.note}</div><div class="ctgt">Target: ${c.target}</div></div>`).join('');}
function delCta(id){ctas=ctas.filter(c=>c.id!==id);triggerAutoSave();renderCtas();}
function addCta(){const d=prompt('Day/Date:');if(!d)return;const ti=prompt('Time:')||'';const a=prompt('Action:')||'';const n=prompt('Note:')||'';const t=prompt('Target:')||'';ctas.push({id:Date.now(),day:d,time:ti,action:a,note:n,target:t});triggerAutoSave();renderCtas();}

// SETTINGS
function loadCfgUI(){applyTheme();['fs-sm','fs-md','fs-lg','fs-xl'].forEach(c=>document.body.classList.remove(c));document.body.classList.add(['fs-sm','fs-md','fs-lg','fs-xl'][cfg.fontSize||1]);const sl=document.getElementById('fs-slider');if(sl)sl.value=cfg.fontSize||1;const pr=document.getElementById('fs-preview');if(pr)pr.textContent=['Small','Medium','Large','XL'][cfg.fontSize||1];const nt=document.getElementById('notif-tog');if(nt)nt.classList.toggle('on',cfg.notif);const gt=document.getElementById('greet-tog');if(gt)gt.classList.toggle('on',cfg.autoGreet);const at=document.getElementById('autosave-tog');if(at)at.classList.toggle('on',cfg.autoSave!==false);updateSaveStatusText();}

// TRANSACTIONS
function addTransaction(){const type=document.getElementById('tx-type').value;const desc=document.getElementById('tx-desc').value.trim();const amount=parseInt(document.getElementById('tx-amount').value)||0;const date=document.getElementById('tx-date').value;const cat=document.getElementById('tx-cat').value;const bizV=document.getElementById('tx-biz').value;if(!desc||!amount||!date)return showNotif('Fill description, amount and date','info');transactions.push({id:txid++,type,desc,amount,date,cat,biz:bizV,ts:new Date(date).getTime()});sv(SK+'_tx',transactions);sv(SK+'_txid',txid);document.getElementById('tx-desc').value='';document.getElementById('tx-amount').value='';renderTxList();showNotif((type==='income'?'Income':'Expense')+' logged: ₦'+amount.toLocaleString(),'success');}
function filterTx(f,el){txFilter=f;document.querySelectorAll('#sec-finance .fchip').forEach(b=>b.classList.remove('on'));el.classList.add('on');renderTxList();}
function delTx(id){transactions=transactions.filter(t=>t.id!==id);sv(SK+'_tx',transactions);renderTxList();}
function renderTxList(){const el=document.getElementById('tx-list');if(!el)return;let list=[...transactions].reverse();if(txFilter!=='all'){if(txFilter==='income'||txFilter==='expense')list=list.filter(t=>t.type===txFilter);else list=list.filter(t=>t.biz===txFilter);}const cnt=document.getElementById('tx-count');if(cnt)cnt.textContent=transactions.length+' entries';if(!list.length){el.innerHTML='<div style="color:var(--muted);font-size:12px;text-align:center;padding:12px">No transactions</div>';return;}el.innerHTML=list.map(t=>`<div class="fin-tx-item"><div style="width:32px;height:32px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:10px;font-family:'DM Mono',monospace;font-weight:700;flex-shrink:0;background:${t.type==='income'?'rgba(92,184,92,.12)':'rgba(224,82,82,.12)'};color:${t.type==='income'?'var(--green)':'var(--red)'}"> ${t.type==='income'?'IN':'OUT'}</div><div style="flex:1;min-width:0"><div style="font-size:13px;font-weight:600;color:var(--text)">${t.desc}</div><div style="font-size:9px;color:var(--muted);margin-top:2px;font-family:'DM Mono',monospace">${(t.cat||'').toUpperCase()} · ${bizLabel(t.biz)} · ${fmtDateStr(t.date)}</div></div><div style="text-align:right;flex-shrink:0"><div style="font-size:13px;font-weight:700;font-family:'DM Mono',monospace;color:${t.type==='income'?'var(--green)':'var(--red)'}">${t.type==='income'?'+':'-'}₦${t.amount.toLocaleString()}</div><button style="background:none;border:none;font-size:14px;cursor:pointer;color:var(--muted);padding:0;margin-top:2px" onclick="delTx(${t.id})">×</button></div></div>`).join('');}
function bizLabel(b){return{salon:'Salon',nails:'Nails',clothing:'Clothing'}[b]||b;}
function fmtDateStr(d){if(!d)return'';const p=d.split('-');return p[2]+'/'+p[1]+'/'+p[0].slice(2);}

// ANALYTICS
function setDateFilter(f,el){anaFilter=f;document.querySelectorAll('#sec-analytics .fchip').forEach(b=>b.classList.remove('on'));el.classList.add('on');const cr=document.getElementById('custom-date-row');if(cr)cr.style.display=f==='custom'?'flex':'none';if(f!=='custom'){anaStart=null;anaEnd=null;renderAnalytics();}}
function applyCustomFilter(){const s=document.getElementById('filter-start').value,e=document.getElementById('filter-end').value;if(!s||!e)return showNotif('Select start and end date','info');anaStart=new Date(s);anaEnd=new Date(e);anaEnd.setHours(23,59,59);anaFilter='custom';renderAnalytics();}
function getFilteredTx(){const now=new Date();return transactions.filter(t=>{const d=new Date(t.date);if(anaFilter==='week'){const dow=now.getDay()||7;const mon=new Date(now);mon.setDate(now.getDate()-dow+1);mon.setHours(0,0,0);const sun=new Date(mon);sun.setDate(mon.getDate()+6);sun.setHours(23,59,59);return d>=mon&&d<=sun;}if(anaFilter==='lastweek'){const dow=now.getDay()||7;const mon=new Date(now);mon.setDate(now.getDate()-dow-6);mon.setHours(0,0,0);const sun=new Date(mon);sun.setDate(mon.getDate()+6);sun.setHours(23,59,59);return d>=mon&&d<=sun;}if(anaFilter==='month')return d.getMonth()===now.getMonth()&&d.getFullYear()===now.getFullYear();if(anaFilter==='lastmonth'){const lm=new Date(now.getFullYear(),now.getMonth()-1,1);const lme=new Date(now.getFullYear(),now.getMonth(),0);return d>=lm&&d<=lme;}if(anaFilter==='custom'&&anaStart&&anaEnd)return d>=anaStart&&d<=anaEnd;return d.getMonth()===now.getMonth()&&d.getFullYear()===now.getFullYear();});}
function getWeekTx(offsetWeeks){const now=new Date();const dow=now.getDay()||7;const mon=new Date(now);mon.setDate(now.getDate()-dow+1-(offsetWeeks*7));mon.setHours(0,0,0,0);const sun=new Date(mon);sun.setDate(mon.getDate()+6);sun.setHours(23,59,59,999);return transactions.filter(t=>{const d=new Date(t.date);return d>=mon&&d<=sun;});}
function renderAnalytics(){const filtered=getFilteredTx();const income=filtered.filter(t=>t.type==='income').reduce((s,t)=>s+t.amount,0);const expense=filtered.filter(t=>t.type==='expense').reduce((s,t)=>s+t.amount,0);const profit=income-expense;const lbl=document.getElementById('ana-range-label');if(lbl){const labels={week:'This Week',lastweek:'Last Week',month:'This Month',lastmonth:'Last Month',custom:'Custom Range'};lbl.textContent='Showing: '+(labels[anaFilter]||'Current Month');}const ai=document.getElementById('ana-income');if(ai)ai.textContent=fmt(income);const ae=document.getElementById('ana-expense');if(ae)ae.textContent=fmt(expense);const ap=document.getElementById('ana-profit');if(ap){ap.textContent=fmt(profit);ap.style.color=profit>=0?'var(--green)':'var(--red)';}const aps=document.getElementById('ana-profit-sub');if(aps)aps.textContent=profit>=0?'Profit':'Loss';const atx=document.getElementById('ana-txcount');if(atx)atx.textContent=filtered.length;const tw=getWeekTx(0);const lw=getWeekTx(1);const twInc=tw.filter(t=>t.type==='income').reduce((s,t)=>s+t.amount,0);const lwInc=lw.filter(t=>t.type==='income').reduce((s,t)=>s+t.amount,0);const twEl=document.getElementById('ana-thisweek-inc');if(twEl)twEl.textContent=fmt(twInc);const lwEl=document.getElementById('ana-lastweek-inc');if(lwEl)lwEl.textContent=fmt(lwInc);renderBarChart(filtered);renderPieChart(filtered);renderInsights(filtered,income,expense,profit,twInc,lwInc);}
function renderBarChart(filtered){const canvas=document.getElementById('chart-bar');if(!canvas)return;const months=[];const now=new Date();for(let i=5;i>=0;i--){const d=new Date(now.getFullYear(),now.getMonth()-i,1);months.push({label:['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][d.getMonth()],m:d.getMonth(),y:d.getFullYear()});}const incData=months.map(mo=>transactions.filter(t=>t.type==='income'&&new Date(t.date).getMonth()===mo.m&&new Date(t.date).getFullYear()===mo.y).reduce((s,t)=>s+t.amount,0));const expData=months.map(mo=>transactions.filter(t=>t.type==='expense'&&new Date(t.date).getMonth()===mo.m&&new Date(t.date).getFullYear()===mo.y).reduce((s,t)=>s+t.amount,0));if(barChart){barChart.destroy();barChart=null;}const ctx=canvas.getContext('2d');barChart=new Chart(ctx,{type:'bar',data:{labels:months.map(m=>m.label),datasets:[{label:'Income',data:incData,backgroundColor:'rgba(92,184,92,.7)',borderRadius:4},{label:'Expenses',data:expData,backgroundColor:'rgba(224,82,82,.6)',borderRadius:4}]},options:{responsive:true,plugins:{legend:{labels:{color:'#888',font:{size:10}}},tooltip:{callbacks:{label:(c)=>'₦'+c.raw.toLocaleString()}}},scales:{x:{ticks:{color:'#888',font:{size:9}},grid:{display:false}},y:{ticks:{color:'#888',font:{size:9},callback:(v)=>v>=1000?'₦'+(v/1000).toFixed(0)+'k':'₦'+v},grid:{color:'rgba(255,255,255,.05)'}}}}});}
function renderPieChart(filtered){const canvas=document.getElementById('chart-pie');if(!canvas)return;const expFiltered=filtered.filter(t=>t.type==='expense');const cats={};expFiltered.forEach(t=>{cats[t.cat]=(cats[t.cat]||0)+t.amount;});const sorted=Object.entries(cats).sort((a,b)=>b[1]-a[1]);let labels=[],data=[],colors=['#d4a843','#5b9bd5','#5cb85c','#e05252','#6a1b9a','#888'];if(sorted.length<=5){labels=sorted.map(([k])=>k.charAt(0).toUpperCase()+k.slice(1));data=sorted.map(([,v])=>v);}else{const top=sorted.slice(0,5);const others=sorted.slice(5).reduce((s,[,v])=>s+v,0);labels=[...top.map(([k])=>k.charAt(0).toUpperCase()+k.slice(1)),'Others'];data=[...top.map(([,v])=>v),others];}if(!data.length){labels=['No expenses'];data=[1];colors=['#2a2418'];}if(pieChart){pieChart.destroy();pieChart=null;}const ctx=canvas.getContext('2d');pieChart=new Chart(ctx,{type:'pie',data:{labels,datasets:[{data,backgroundColor:colors.slice(0,labels.length),borderWidth:0}]},options:{responsive:true,plugins:{legend:{position:'bottom',labels:{color:'#888',font:{size:10},padding:8}},tooltip:{callbacks:{label:(c)=>c.label+': ₦'+c.raw.toLocaleString()}}}}});}
function renderInsights(filtered,income,expense,profit,twInc,lwInc){const el=document.getElementById('insights-container');if(!el)return;const insights=[];if(filtered.length===0){el.innerHTML='<div class="insight-item" style="color:var(--muted)">Log transactions to see insights.</div>';return;}if(profit>0)insights.push({icon:'💰',text:'Profit of ₦'+profit.toLocaleString()+' this period.'});else if(profit<0)insights.push({icon:'⚠',text:'Loss of ₦'+Math.abs(profit).toLocaleString()+'. Review expenses.'});if(twInc>lwInc&&lwInc>0)insights.push({icon:'↑',text:'Income up this week by ₦'+(twInc-lwInc).toLocaleString()+'.'});const topCat=filtered.filter(t=>t.type==='expense').reduce((acc,t)=>{acc[t.cat]=(acc[t.cat]||0)+t.amount;return acc;},{});const topEntry=Object.entries(topCat).sort((a,b)=>b[1]-a[1])[0];if(topEntry)insights.push({icon:'📊',text:'Top expense: '+topEntry[0]+' at ₦'+topEntry[1].toLocaleString()+'.'});el.innerHTML=insights.length?insights.map(i=>`<div class="insight-item"><span class="insight-icon">${i.icon}</span>${i.text}</div>`).join(''):'<div class="insight-item" style="color:var(--muted)">Keep logging for more insights.</div>';}

// CALENDAR
function calPrev(){calMonth--;if(calMonth<0){calMonth=11;calYear--;}renderCalendar();}
function calNext(){calMonth++;if(calMonth>11){calMonth=0;calYear++;}renderCalendar();}
function renderCalendar(){const el=document.getElementById('cal-days');const lbl=document.getElementById('cal-month-lbl');if(lbl)lbl.textContent=MONTHS_AR[calMonth]+' '+calYear;const firstDay=new Date(calYear,calMonth,1).getDay();const offset=(firstDay===0?6:firstDay-1);const daysInMonth=new Date(calYear,calMonth+1,0).getDate();const today=new Date();const txDates=new Set(transactions.map(t=>t.date));let html='';for(let i=0;i<offset;i++)html+='<div class="cal-day empty"></div>';for(let d=1;d<=daysInMonth;d++){const dateStr=calYear+'-'+(String(calMonth+1).padStart(2,'0'))+'-'+(String(d).padStart(2,'0'));const isToday=d===today.getDate()&&calMonth===today.getMonth()&&calYear===today.getFullYear();const hasData=txDates.has(dateStr);html+=`<div class="cal-day${isToday?' today':''}${hasData?' has-data':''}" onclick="showCalDay('${dateStr}',${d})">${d}</div>`;}if(el)el.innerHTML=html;document.getElementById('cal-detail-wrap').innerHTML='';}
function showCalDay(dateStr,day){const el=document.getElementById('cal-detail-wrap');if(!el)return;const dayTx=transactions.filter(t=>t.date===dateStr);const inc=dayTx.filter(t=>t.type==='income').reduce((s,t)=>s+t.amount,0);const exp=dayTx.filter(t=>t.type==='expense').reduce((s,t)=>s+t.amount,0);const d=new Date(dateStr);const label=d.toLocaleDateString([],{weekday:'long',day:'numeric',month:'long'});el.innerHTML=`<div class="cal-detail"><div class="cal-det-date">${label}</div>${dayTx.length?`<div style="display:flex;gap:8px;margin-bottom:10px"><div style="flex:1;background:rgba(92,184,92,.08);border-radius:8px;padding:8px;text-align:center"><div style="font-size:8px;color:var(--green);font-family:'DM Mono',monospace;font-weight:600;margin-bottom:3px">INCOME</div><div style="font-size:13px;font-weight:700;color:var(--green);font-family:'DM Mono',monospace">${fmt(inc)}</div></div><div style="flex:1;background:rgba(224,82,82,.08);border-radius:8px;padding:8px;text-align:center"><div style="font-size:8px;color:var(--red);font-family:'DM Mono',monospace;font-weight:600;margin-bottom:3px">EXPENSES</div><div style="font-size:13px;font-weight:700;color:var(--red);font-family:'DM Mono',monospace">${fmt(exp)}</div></div></div>${dayTx.map(t=>`<div style="display:flex;justify-content:space-between;padding:7px 0;border-bottom:1px solid var(--border);font-size:12px"><span style="color:var(--text)">${t.desc}</span><span style="font-family:'DM Mono',monospace;color:${t.type==='income'?'var(--green)':'var(--red)'}">${t.type==='income'?'+':'-'}₦${t.amount.toLocaleString()}</span></div>`).join('')}`:'<div style="font-size:12px;color:var(--muted)">No transactions this day.</div>'}</div>`;}

// CONTENT
const CONTENT_BANK={salon:[{type:'Service Highlight',idea:'Feature locs, microlocs or loc styling transformation',caption:"Locs that speak for themselves. Book your slot.",platform:'Instagram',format:'Reel'},{type:'Studio Walkthrough',idea:'Tour of studio — show the space',caption:"This is where the magic happens. Come see us.",platform:'Instagram',format:'Reel'},{type:'Transformation',idea:'Before and after hair or brow/lash service',caption:"The before is fine. The after is everything.",platform:'Instagram',format:'Carousel'},{type:'Weekly Slots',idea:'Post open appointment slots for the week',caption:"Slots going fast. DM or WhatsApp to confirm yours.",platform:'WhatsApp',format:'Status'},{type:'Service Menu',idea:'Clean visual of all services offered',caption:"From locs to nails to brows. One studio. All of it.",platform:'Instagram',format:'Carousel'},{type:'Behind The Scenes',idea:'Day-in-the-life at the salon',caption:"A good day here looks like this.",platform:'Instagram',format:'Reel'},{type:'Nail Feature',idea:'Showcase nail extensions, BIAB or poly gel set',caption:"Fresh set energy. Book yours now.",platform:'Instagram',format:'Post'}],nails:[{type:'Nail Set Feature',idea:'Full nail set showcase — multiple angles',caption:"Fresh set energy. DM to book your slot.",platform:'Instagram',format:'Reel'},{type:'Trend Alert',idea:'Recreate a trending nail design',caption:"You asked, we delivered. Booking out fast.",platform:'Instagram',format:'Post'},{type:'Before vs After',idea:'Client nails transformation',caption:"Same hands, different confidence.",platform:'Instagram',format:'Carousel'},{type:'Engagement',idea:'Which nail style fits your vibe?',caption:"Pick your vibe. Drop it in the comments.",platform:'Instagram',format:'Post'},{type:'Price List',idea:'Clean visual of nail services and pricing',caption:"No surprises. Just clarity.",platform:'WhatsApp',format:'Status'},{type:'Client Shoutout',idea:'Showcase a happy client nail result',caption:"Client satisfaction hits different.",platform:'Instagram',format:'Post'}],clothing:[{type:'Outfit Replication',idea:'Trending outfit recreated your way',caption:"We saw it. We built it. Ours hits different.",platform:'Instagram',format:'Reel'},{type:'New Drop',idea:'Feature a new fabric or design just arrived',caption:"New drop just landed. Limited pieces — move fast.",platform:'Instagram',format:'Post'},{type:'Before vs After',idea:'Reference look vs your version',caption:"Before → After. Yours always wins.",platform:'Instagram',format:'Carousel'},{type:'Engagement Poll',idea:'Left or right? Two outfit variations',caption:"Left or Right? Tell us in the comments.",platform:'Instagram',format:'Carousel'},{type:'Product Highlight',idea:'Close-up of fabric texture and design details',caption:"The details you can't see until you hold it.",platform:'Instagram',format:'Post'}]};
function setCPBrand(b,el){cpBrand=b;document.querySelectorAll('.cp-brand-btn').forEach(btn=>btn.classList.remove('on'));el.classList.add('on');}
function generateContentIdeas(){const bank=CONTENT_BANK[cpBrand]||CONTENT_BANK.salon;const shuffled=[...bank].sort(()=>Math.random()-.5).slice(0,5);const el=document.getElementById('content-ideas-list');if(!el)return;el.innerHTML=shuffled.map((c,i)=>`<div class="cp-idea"><div class="cp-type">${c.type}</div><div class="cp-idea-txt">${c.idea}</div><div class="cp-caption">"${c.caption}"</div><div class="cp-meta"><span class="cp-tag platform">${c.platform}</span><span class="cp-tag format">${c.format}</span><span class="cp-tag" style="background:rgba(212,168,67,.1);color:var(--accent)">${cpBrand.toUpperCase()}</span></div><div style="display:flex;gap:6px"><button class="cp-cvt" onclick="saveContentIdea(${i},'${cpBrand}','${encodeURIComponent(JSON.stringify(c))}')">💾 Save</button><button class="cp-cvt" onclick="convertContentToTask('${encodeURIComponent(c.idea)}')">✓ Add Task</button></div></div>`).join('');}
function saveContentIdea(idx,brand,encodedIdea){try{const c=JSON.parse(decodeURIComponent(encodedIdea));savedContent.push({id:cpid++,brand,...c,savedAt:new Date().toISOString()});sv(SK+'_content',savedContent);sv(SK+'_cpid',cpid);renderSavedContent();showNotif('Idea saved','success');}catch(e){}}
function convertContentToTask(encodedIdea){try{const idea=decodeURIComponent(encodedIdea);tasks.push({id:nid++,text:'Content: '+idea.slice(0,60),tag:'content',amount:null,done:false,urgent:false,day:'',time:''});triggerAutoSave();renderTasks();showNotif('Added to Tasks','success');}catch(e){}}
function delSavedContent(id){savedContent=savedContent.filter(c=>c.id!==id);sv(SK+'_content',savedContent);renderSavedContent();}
function renderSavedContent(){const el=document.getElementById('saved-content-list');if(!el)return;if(!savedContent.length){el.innerHTML='<div style="padding:0 16px 12px;color:var(--muted);font-size:12px;font-style:italic">No saved ideas yet.</div>';return;}el.innerHTML=[...savedContent].reverse().map(c=>`<div class="cp-idea"><div class="cp-type">${c.type}</div><div class="cp-idea-txt">${c.idea}</div><div class="cp-meta"><span class="cp-tag platform">${c.platform}</span><span class="cp-tag format">${c.format}</span><span class="cp-tag" style="background:rgba(212,168,67,.1);color:var(--accent)">${(c.brand||'').toUpperCase()}</span></div><button class="cp-cvt" onclick="delSavedContent(${c.id})" style="color:var(--red)">Remove</button></div>`).join('');}

// MEALS
const MEAL_DB={breakfast:[{name:'Oats with banana & honey',cal:320},{name:'Bread & egg sauce',cal:350},{name:'Akara & pap (ogi)',cal:280},{name:'Moi moi & custard',cal:300},{name:'Boiled yam & egg',cal:380},{name:'Noodles & egg',cal:340},{name:'Plantain porridge',cal:310},{name:'Beans & plantain',cal:400},{name:'Boiled sweet potato & tea',cal:290}],lunch:[{name:'Jollof rice & chicken',cal:580},{name:'Eba & egusi soup',cal:550},{name:'Amala & ewedu soup',cal:480},{name:'Eba & okra soup with fish',cal:500},{name:'Boiled yam & pepper sauce',cal:420},{name:'Fried plantain & beans',cal:460},{name:'Rice & beans',cal:490},{name:'Ofada rice & ayamase',cal:560},{name:'Semovita & bitterleaf soup',cal:510}],dinner:[{name:'Light soup & wheat fufu',cal:420},{name:'Grilled fish & boiled yam',cal:480},{name:'Pepper soup',cal:300},{name:'Noodles stir-fry',cal:380},{name:'Plantain & vegetable sauce',cal:350},{name:'Yam pottage (asaro)',cal:410},{name:'Rice & tomato egg stew',cal:450},{name:'Ofe akwu & eba',cal:520}]};
function generateMeals(){const days=['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];const shuffle=arr=>[...arr].sort(()=>Math.random()-.5);const bf=shuffle(MEAL_DB.breakfast);const ln=shuffle(MEAL_DB.lunch);const dn=shuffle(MEAL_DB.dinner);const el=document.getElementById('meals-container');if(!el)return;el.innerHTML=days.map((day,i)=>`<div class="meal-card"><div class="meal-day-hdr">${day}</div><div class="meal-slot"><div class="meal-time-lbl">AM</div><div class="meal-name">${bf[i%bf.length].name}</div><div class="meal-cal">${bf[i%bf.length].cal}kcal</div></div><div class="meal-slot"><div class="meal-time-lbl">PM</div><div class="meal-name">${ln[i%ln.length].name}</div><div class="meal-cal">${ln[i%ln.length].cal}kcal</div></div><div class="meal-slot"><div class="meal-time-lbl">EVE</div><div class="meal-name">${dn[i%dn.length].name}</div><div class="meal-cal">${dn[i%dn.length].cal}kcal</div></div></div>`).join('');showNotif('Meal plan generated!','success');}

document.getElementById('tx-date').value=new Date().toISOString().split('T')[0];

// INIT
(function initApp(){
  applyTheme();
  ['fs-sm','fs-md','fs-lg','fs-xl'].forEach(c=>document.body.classList.remove(c));
  document.body.classList.add(['fs-sm','fs-md','fs-lg','fs-xl'][cfg.fontSize||1]);
  applyDate();
  applyGreeting();
  applyQuote();
  updateHomeStats();
  renderPriorities();
  renderBiz();
  renderTxList();
  renderSavedContent();
  const ls=ld(SK+'_lastsaved',null);if(ls){lastSaved=new Date(ls);updateSaveStatusText();}
  setTimeout(()=>{
    const u=tasks.filter(t=>t.urgent&&!t.done);
    if(u.length&&cfg.notif)showNotif(u.length+' urgent task'+(u.length>1?'s':'')+' need attention','urgent',5000);
    else if(cfg.notif)showNotif('COLE OS ready. Stay focused, Gbemi.','info',3000);
  },2400);
})();
</script>
</body>
</html>
