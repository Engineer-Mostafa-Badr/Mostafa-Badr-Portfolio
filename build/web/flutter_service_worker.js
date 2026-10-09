'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"404.html": "05a4ee868143324de28403bbe420e9aa",
"assets/AssetManifest.bin": "354cff8e31cad5c5cb1be3e36efde3d9",
"assets/AssetManifest.bin.json": "77eef6cda0af2ef0ed2806e983913c29",
"assets/AssetManifest.json": "37f29aad86be10e92ce0bda0e8550d52",
"assets/assets/images/alawaly/%25D8%25A7%25D9%2584%25D9%2585%25D8%25B4%25D8%25A7%25D8%25B1%25D9%258A%25D8%25B9.webp": "e768fdd9aeced5e3d71fe7a1c5dae1e0",
"assets/assets/images/alawaly/%25D8%25AA%25D9%2581%25D8%25A7%25D8%25B5%25D9%258A%25D9%2584%2520%25D8%25A7%25D9%2584%25D9%2585%25D8%25B4%25D8%25B1%25D9%2588%25D8%25B9.webp": "55fa1ca038b8d5f623cfce186e33d98b",
"assets/assets/images/alawaly/%25D8%25AA%25D9%2581%25D8%25A7%25D8%25B5%25D9%258A%25D9%2584%2520%25D8%25A7%25D9%2584%25D9%2588%25D8%25AD%25D8%25AF%25D8%25A9.webp": "d2cb58770809a0c01e1f240fee815934",
"assets/assets/images/alawaly/%25D9%2586%25D8%25AA%25D8%25A7%25D8%25A6%25D8%25AC%2520%25D8%25A7%25D9%2584%25D8%25A8%25D8%25AD%25D8%25AB%2520%25D8%25B9%25D9%2584%25D9%258A%2520%25D8%25A7%25D9%2584%25D8%25AE%25D8%25B1%25D9%258A%25D8%25B7%25D8%25A92.webp": "dac5c9465b9145790754881cc95e60e7",
"assets/assets/images/alawaly/cover.webp": "5ca0f5ce5cc51c7bdce2759feaa1591b",
"assets/assets/images/alawaly/sign%2520up2.webp": "4088d8adbc74e54f9cbe73350a27c1d6",
"assets/assets/images/captain_drive/cover.webp": "027d1c3c1ec9fa381c63f8bc4f525ef6",
"assets/assets/images/captain_drive/iPhone%252014%2520&%252015%2520Pro%2520Max%2520-%252075.webp": "293396651b8063d2ebaa4bd11590fad9",
"assets/assets/images/captain_drive/iPhone%252014%2520&%252015%2520Pro%2520Max%2520-%252076.webp": "d64e7afa854b527a1d84528db4651a6d",
"assets/assets/images/captain_drive/iPhone%252014%2520&%252015%2520Pro%2520Max%2520-%252077.webp": "2ad3433c59589c760d71b2c331e59826",
"assets/assets/images/captain_drive/iPhone%252014%2520&%252015%2520Pro%2520Max%2520-%252084.webp": "1552d64939d3042cfe5dd30545aea474",
"assets/assets/images/captain_drive/iPhone%252014%2520&%252015%2520Pro%2520Max%2520-%252086.webp": "03952d02c2f48b40ff52f1f68a0956b3",
"assets/assets/images/captain_drive/iPhone%252014%2520&%252015%2520Pro%2520Max%2520-%252089.webp": "cdb0224902e0a6b35472560fe8d2b9b1",
"assets/assets/images/certificates/1735110803287.webp": "58c4533ecff5f6d47febb08f9d5972b3",
"assets/assets/images/certificates/UC-310e8a5d-2690-4f74-9cdc-90313d329737.webp": "fdc5196f7322d39a9c65349fae95ab13",
"assets/assets/images/certificates/UC-80363353-13c9-4b82-ab7f-1f67da6cae14.webp": "3caf1a26dc436b6f23cd40e9c6aaafa7",
"assets/assets/images/certificates/UC-ab120903-41b3-4f64-81c1-913711fbce18.webp": "d91cfb7f74575392fb60982d5bffbd42",
"assets/assets/images/certificates/UC-b40e0452-2e45-4ea5-8c02-8ee6eb0d4be5.webp": "e63b3542010b6cbea6b8b7c06e6dbac7",
"assets/assets/images/certificates/UC-bf5a00eb-7377-4ced-9f19-e9e8b84b7373.webp": "5261c8397ea3b12144142dbfe14eecdf",
"assets/assets/images/ecommerce/cover.webp": "62cdd5c65d4abf4061e901759442b931",
"assets/assets/images/ecommerce/IMG-20250411-WA0088.webp": "22b6254f8ae8ab53dfe2f164107357af",
"assets/assets/images/ecommerce/IMG-20250411-WA0090.webp": "5d8215c3b0c8ed6ac6ee8323e2ea348d",
"assets/assets/images/ecommerce/IMG-20250411-WA0096.webp": "349870027c76609471261200a38f0293",
"assets/assets/images/ecommerce/IMG-20250411-WA0099.webp": "710772b73dbe1c9d0acc94a1a7f3a59a",
"assets/assets/images/ecommerce/IMG-20250411-WA0101.webp": "18f8ce98380a5f3cfbf65a4bb0015b2e",
"assets/assets/images/ecommerce/IMG-20250411-WA0104.webp": "61e97a7f325d0dc88a1f54f2fe49b1c8",
"assets/assets/images/fortynine/1.webp": "9135bb0034b9e78b22e3a5fd8bb9a2f1",
"assets/assets/images/fortynine/2.webp": "982bad97fb2f41d3d4bd2198eeadc6d8",
"assets/assets/images/fortynine/3.webp": "3ec64c86786eb872c3c450d7bf001c1e",
"assets/assets/images/fortynine/4.webp": "cb2d3dd5d835bbec0a1f5b2ff8e09c2a",
"assets/assets/images/fortynine/5.webp": "987911ad1e80e30dac4df1586e69dc0c",
"assets/assets/images/fortynine/6.webp": "61953dd521dae848d717fa80a1c805b2",
"assets/assets/images/fortynine/7.webp": "49c1920c8e0987b0a7e85c0ec17435a2",
"assets/assets/images/fortynine/cover.webp": "0e9685e5b8788b38e70136c84224f5c6",
"assets/assets/images/haj/1.webp": "eaf7b6fe70b571b45eccce411437bfff",
"assets/assets/images/haj/2.webp": "0bde0cd6d9b9c3e7cec1dfda3b9c230d",
"assets/assets/images/haj/3.webp": "56d256403cf66e7a8503cbfeb6facf59",
"assets/assets/images/haj/4.webp": "199174770d82be5b3137e8a3fec12399",
"assets/assets/images/haj/5.webp": "ef2fe6be61a83c7836a95ede218bcd68",
"assets/assets/images/haj/6.webp": "41dab13fe5dd5ad9f799b79dc16db88a",
"assets/assets/images/haj/7.webp": "fb29f03ea6ec6ebb3ad4dd893709f837",
"assets/assets/images/haj/8.webp": "1bc588dcc312d484adfdc5cf86d4ab4d",
"assets/assets/images/haj/cover.webp": "a55bf4719f4e3c065e3a9f944e65d676",
"assets/assets/images/hr/cover.webp": "24c45f058ac7b6b6c87ce68ab25b0066",
"assets/assets/images/hr/Screenshot_1786433069.webp": "5af031a3b2bd0496059b97612f9c9f18",
"assets/assets/images/hr/Screenshot_1786433073.webp": "4884a7fe26ec3ca5ce36c4c825dab855",
"assets/assets/images/hr/Screenshot_1786433088.webp": "24258450c19ae521eb8b13fec0f7f6ed",
"assets/assets/images/hr/Screenshot_1786433144.webp": "1592cb8691b3f70f9ffe519f1dc4a3e6",
"assets/assets/images/logo/7c1ae715-563b-4455-9465-c93bd935db61.webp": "9ba270dbb2635d86053801068187a889",
"assets/assets/images/logo/portfolio.svg": "dd49b526322907113025772460535bc7",
"assets/assets/images/my_photo/portrait.webp": "a7a4dd4305531150e221b41495189827",
"assets/assets/images/rack/04_scale.webp": "c691a67cd3405f2f378511d0d6914581",
"assets/assets/images/rack/cover.webp": "c6a3c5d3cb312e87511374a08e21d682",
"assets/assets/images/rack/image.webp": "ca4089c8f202a3723a3cbed5fb81f78d",
"assets/assets/images/rack/rack.webp": "4008c22515ca9ba52c2b0d6ffaaa1c8a",
"assets/assets/images/rack/rack2.webp": "44288c5464a25b74168cbec183a55794",
"assets/assets/images/rack/unnamed.webp": "4b3833f556dc0715258952ab7c72bb57",
"assets/assets/images/saqqar/cover.webp": "f571693a487d6b36dbc107dee25d43cd",
"assets/assets/images/saqqar/Screenshot_1783481354.webp": "e3a6d500f6a7e44531819c1cdee0abc1",
"assets/assets/images/saqqar/Screenshot_1784388260.webp": "060fb27032b47f8ca1a87cbc74c87760",
"assets/assets/images/saqqar/Screenshot_1784388612.webp": "aab0952e22cc519baac01e374f64e0bf",
"assets/assets/images/saqqar/Screenshot_1784388623.webp": "8acc9024709f15e655a1a036f58a140e",
"assets/assets/images/sijil/cover.webp": "5858f04accacfc7e1fd42aa936605134",
"assets/assets/images/sijil/Screenshot_1788436818.webp": "94b9a2306c082f2c2b2162954181f73a",
"assets/assets/images/sijil/Screenshot_1788436834.webp": "011d706710a1febf9be708f9af658338",
"assets/assets/images/sijil/Screenshot_1788436950.webp": "636f94afb5a23a75ec37a7ff65b0bba1",
"assets/assets/images/sijil/Screenshot_1788436978.webp": "be7ae8c85bb8c5b1252774b322cbb795",
"assets/assets/images/sprints/cover.webp": "26963ee599a932d887abe3b09fe46cf6",
"assets/assets/images/sprints/Screenshot_1783863008.webp": "10bb37be5942e7d0725e319152cd1657",
"assets/assets/images/sprints/Screenshot_1783863014.webp": "37440cde0feba1b5ae6a284b927804ad",
"assets/assets/images/sprints/Screenshot_1783863021.webp": "43cd33d8aecef231e343ea986972ccc9",
"assets/assets/images/sprints/Screenshot_1783863046.webp": "7136ebfe910904f3ef16764c1dda3cac",
"assets/assets/images/sprints/Screenshot_1783863050.webp": "77cbc8a1c78f32cbcfeaecfcfd8a6256",
"assets/assets/images/sprints/Screenshot_1783863053.webp": "cb44140daff46b68a2e794973a966ba6",
"assets/assets/images/visits/cover.webp": "4720ea7d78a15cd1aa5f9c3ae657351e",
"assets/assets/images/visits/Screenshot_1786260328.webp": "7e22edb76333fca16c2dcf70539c9bf3",
"assets/assets/images/visits/Screenshot_1786260334.webp": "004beb0e5f7ef818e520360241f2d493",
"assets/assets/images/visits/Screenshot_1786260340.webp": "1595405387e7f924a89d50096215a455",
"assets/assets/images/visits/Screenshot_1786260349.webp": "e01484469367d9da39ea9a302f8b3efb",
"assets/assets/images/visits/Screenshot_1786260427.webp": "0169a901cd2e2ebec4921ea8f35a2d44",
"assets/FontManifest.json": "c75f7af11fb9919e042ad2ee704db319",
"assets/fonts/MaterialIcons-Regular.otf": "b0a56f59b7108cd8faf2f197fc9fda9b",
"assets/NOTICES": "fa0db5540d16ac4a5b7bb75646f4ed26",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Brands-Regular-400.otf": "076c09df0796b1e065c8153acc03b571",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Regular-400.otf": "75e4d4f6c9dee623e4180f7409d09f13",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Solid-900.otf": "79f645e59795529a5a745b91c8f6d1f4",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"cv/Mostafa-Badr-CV.pdf": "3f4d3491ea6c26603394bdce648b3728",
"favicon.png": "645b34688834c83742cc8793bc797872",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "8264528088cd6e1105898eccfbfde0e3",
"index.html": "0c542254053ae932cdbe76bc88231e69",
"/": "0c542254053ae932cdbe76bc88231e69",
"main.dart.js": "2997c6402c3f3ca0f963841652cbe19b",
"manifest.json": "1573fb785e0f8ba8d18ee88d58cf39bf",
"og-image.png": "6040e63755099657ac912203334dcfc2",
"robots.txt": "7616b79820dbc3d749e64574e51ffbb5",
"sitemap.xml": "95b506625e79e1fcde79f4d69c7b60ba",
"version.json": "e0387339007850b51aa777c380787d5b",
"_headers": "5a777ec2d409b523eec7fa4bfc2a911f",
"_redirects": "03d9df6a07ba0d7d3f11eff796d77b39"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
