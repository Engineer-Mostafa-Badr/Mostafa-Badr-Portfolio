'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "7199532435fcb280b4bcaadc1d0db3a5",
"assets/AssetManifest.bin.json": "e1f6bf2dca8207635d1a18753ed009c0",
"assets/AssetManifest.json": "fba8c552fed862c25feb41042c32b970",
"assets/assets/images/alawaly/%25D8%25A7%25D9%2584%25D9%2585%25D8%25B4%25D8%25A7%25D8%25B1%25D9%258A%25D8%25B9.png": "90f90b7c6f0ca7b9bb572f188c5fba88",
"assets/assets/images/alawaly/%25D8%25AA%25D9%2581%25D8%25A7%25D8%25B5%25D9%258A%25D9%2584%2520%25D8%25A7%25D9%2584%25D9%2585%25D8%25B4%25D8%25B1%25D9%2588%25D8%25B9.png": "289946f98405b183711a542c1d86ec15",
"assets/assets/images/alawaly/%25D8%25AA%25D9%2581%25D8%25A7%25D8%25B5%25D9%258A%25D9%2584%2520%25D8%25A7%25D9%2584%25D9%2588%25D8%25AD%25D8%25AF%25D8%25A9.png": "7223f027a285e5790bd77bf84ef22f8c",
"assets/assets/images/alawaly/%25D9%2586%25D8%25AA%25D8%25A7%25D8%25A6%25D8%25AC%2520%25D8%25A7%25D9%2584%25D8%25A8%25D8%25AD%25D8%25AB%2520%25D8%25B9%25D9%2584%25D9%258A%2520%25D8%25A7%25D9%2584%25D8%25AE%25D8%25B1%25D9%258A%25D8%25B7%25D8%25A92.png": "cf2d538c2ddbf22a55c72d270bcc614a",
"assets/assets/images/alawaly/sign%2520up2.png": "7ebde1dd83cb9042fa82c0aa13b3d78f",
"assets/assets/images/al_dokan/%25D8%25A7%25D9%2584%25D8%25B4%25D8%25A7%25D9%2584%25D9%258A%25D9%2587%25D8%25A7%25D8%25AA.png": "fd24e1681364216f97fd93ba657d7894",
"assets/assets/images/al_dokan/Chalet%2520page.png": "4c3d0044b4c1ffe4c2c7d8be7fb0d96e",
"assets/assets/images/al_dokan/filled%2520search.png": "26f8ef5bc8eb5b6677e17197e29a403f",
"assets/assets/images/al_dokan/Home%2520page1.png": "2dec47a7cb07ab65d26cb36a1b98096b",
"assets/assets/images/al_dokan/products%2520listing.png": "1aa7f61f53ccccd60079103a57a4ade1",
"assets/assets/images/al_dokan/splash%2520Screen1.png": "480fd473298701dadda443f1e73ba46f",
"assets/assets/images/captain_drive/iPhone%252014%2520&%252015%2520Pro%2520Max%2520-%252075.png": "b448b55ed86ed4287b8eadaff7baeca8",
"assets/assets/images/captain_drive/iPhone%252014%2520&%252015%2520Pro%2520Max%2520-%252076.png": "31c5a3836b859784bca67a638fddf7d9",
"assets/assets/images/captain_drive/iPhone%252014%2520&%252015%2520Pro%2520Max%2520-%252077.png": "b325b34baabe11a159d391ae22d6ac2f",
"assets/assets/images/captain_drive/iPhone%252014%2520&%252015%2520Pro%2520Max%2520-%252084.png": "8e9b48332241cc253ab6daaf7098bf68",
"assets/assets/images/captain_drive/iPhone%252014%2520&%252015%2520Pro%2520Max%2520-%252086.png": "76cbc58613efe0758793a694e46aa193",
"assets/assets/images/captain_drive/iPhone%252014%2520&%252015%2520Pro%2520Max%2520-%252089.png": "bd2533c58e31c38528b4d7593a401639",
"assets/assets/images/certificates/1735110803287.jpg": "9db43490840475e9c6973d622adf4f1a",
"assets/assets/images/certificates/UC-310e8a5d-2690-4f74-9cdc-90313d329737.jpg": "f99cfd0b805b8e822b55c38ff29caf42",
"assets/assets/images/certificates/UC-80363353-13c9-4b82-ab7f-1f67da6cae14.jpg": "3045885c7d6f21f83415182b539ffb7d",
"assets/assets/images/certificates/UC-ab120903-41b3-4f64-81c1-913711fbce18.jpg": "b12d54b84b9cd61686fcd82b1dd7bf10",
"assets/assets/images/certificates/UC-b40e0452-2e45-4ea5-8c02-8ee6eb0d4be5.jpg": "6571d74a73d90f75ed9a816b5f97d7ff",
"assets/assets/images/certificates/UC-bf5a00eb-7377-4ced-9f19-e9e8b84b7373.jpg": "c80844fe6df3423a7b7bc99322d4a06e",
"assets/assets/images/doctor/02_Onboarding%2520screen-01.png": "b5f86f64a8aff27bdfa260945643a423",
"assets/assets/images/doctor/05_Home%2520screen.png": "2bf341e3d1dbb6ccb8214335c066867d",
"assets/assets/images/doctor/06_Doctor%2520Live%2520Chat%2520screen.png": "f4a29b8d1532f7777781ab5c632fd6f2",
"assets/assets/images/doctor/10_Poplular%2520doctor%2520screen.png": "704da90fead4f8870dba915f808dc3bf",
"assets/assets/images/doctor/13_Doctor%2520appointment%2520screen-01.png": "4059611334a41fc7e2190206f2131533",
"assets/assets/images/doctor/21_Menu%2520screen.png": "317508870a07aeed785d857d9f3b81bb",
"assets/assets/images/ecommerce/IMG-20250411-WA0088.jpg": "36f4cb450be9c77302e1e87022b6f2f3",
"assets/assets/images/ecommerce/IMG-20250411-WA0090.jpg": "66915d746f5ab1580d0e977c826b4ffb",
"assets/assets/images/ecommerce/IMG-20250411-WA0096.jpg": "cf6eeef827a2ca5ff91903abe004e309",
"assets/assets/images/ecommerce/IMG-20250411-WA0099.jpg": "562ac9b60c5c9fcd1b35314fc848cdfd",
"assets/assets/images/ecommerce/IMG-20250411-WA0101.jpg": "0c91d51e9334ed503dfde22223ee02ba",
"assets/assets/images/ecommerce/IMG-20250411-WA0104.jpg": "391aa0d8c3dac9b7f2b02b47a61f77c7",
"assets/assets/images/logo/7c1ae715-563b-4455-9465-c93bd935db61.png": "e3a972d154c54b1a8c6f5e1916b72102",
"assets/assets/images/logo/portfolio.svg": "dd49b526322907113025772460535bc7",
"assets/assets/images/marketi/All_Brands_Page.png": "5204f0b011a6d1fbada511b1d7c17127",
"assets/assets/images/marketi/All_Categories_Page.png": "a08cb306d5b32b594ff451ca4c135221",
"assets/assets/images/marketi/Buy_Again_Page.png": "e7e43620a4620ecd0f3bf6145517f2ac",
"assets/assets/images/marketi/Cart_Empty.png": "02f8a69e8f21774fd387cf144cc8d5f7",
"assets/assets/images/marketi/Favorites_Page.png": "d0c279873463cf7fa05bd180c7db5828",
"assets/assets/images/marketi/Product_List.png": "65b3d42e7cd04b337c4be2eaff826b4b",
"assets/assets/images/mubasher/catigories.png": "1e27a5285ef6f48dde2435f7495c1024",
"assets/assets/images/mubasher/My%2520banners.png": "f5bce2a8b3359da90a6185f6e3d19768",
"assets/assets/images/mubasher/Product%2520Tour%2520-%252001.png": "dafd3300a9e27f66973fc17e5c14e43b",
"assets/assets/images/mubasher/Product%2520Tour%2520-%252003.png": "a1f6f7ba5ba2c8cab3a8507848ef02c6",
"assets/assets/images/mubasher/Profile%2520Detail2.png": "4b4d1c262d40d9958b8484aec40ad01f",
"assets/assets/images/mubasher/Top%2520Locations%2520-%2520Location%2520Detail.png": "4cd95e43245f72732c9f64a617a00d3f",
"assets/assets/images/my_photo/5564545.png": "eeb6258c885e3684f5e1ad0a871f44a9",
"assets/assets/images/social_media/Screenshot%2520(58).png": "b2d4467f1e804ee200e05b0dfe350897",
"assets/assets/images/social_media/Screenshot%2520(59).png": "ef9d9b6b61d10252d911135a3c0fe3e4",
"assets/assets/images/social_media/Screenshot%2520(60).png": "3b8ba215376767d04434fa332fe28051",
"assets/assets/images/social_media/Screenshot%2520(61).png": "0bcc508bacab71448cdd82c6c736376f",
"assets/assets/images/social_media/Screenshot%2520(62).png": "6c6174afd611af0983d58be30b7da5cb",
"assets/assets/images/social_media/Screenshot%2520(63).png": "952da357030b49e3cffd25f3df50e46e",
"assets/FontManifest.json": "c75f7af11fb9919e042ad2ee704db319",
"assets/fonts/MaterialIcons-Regular.otf": "d09087793869f08dc7dc469310fc105b",
"assets/NOTICES": "72eec09ba5e93e042534157c96e0bd0f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Brands-Regular-400.otf": "e9b52fecc7af780a80e52314612a2299",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Regular-400.otf": "b2703f18eee8303425a5342dba6958db",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Solid-900.otf": "cc1ed0a90563aeb4cdf75b3db121a179",
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
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "865b6c72c5081c6974692c7e9b5eb794",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "e6ca970ab1d4c9fb71e49a241f59dfed",
"/": "e6ca970ab1d4c9fb71e49a241f59dfed",
"main.dart.js": "4d61bdd44ceef9841050168c80a47ea3",
"manifest.json": "50075f2b0249c6cbe2a1c3f936a68bef",
"version.json": "e0387339007850b51aa777c380787d5b"};
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
