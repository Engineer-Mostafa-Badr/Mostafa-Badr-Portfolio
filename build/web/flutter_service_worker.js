'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"404.html": "05a4ee868143324de28403bbe420e9aa",
"assets/AssetManifest.bin": "b2a2b472f2a79b0e42a95786c36d5930",
"assets/AssetManifest.bin.json": "d121ef3bf4b42e0c0ad342c18f24ac5c",
"assets/AssetManifest.json": "47b210ba38c22a50bab126d11dcd3781",
"assets/assets/images/alawaly/%25D8%25A7%25D9%2584%25D9%2585%25D8%25B4%25D8%25A7%25D8%25B1%25D9%258A%25D8%25B9.png": "90f90b7c6f0ca7b9bb572f188c5fba88",
"assets/assets/images/alawaly/%25D8%25AA%25D9%2581%25D8%25A7%25D8%25B5%25D9%258A%25D9%2584%2520%25D8%25A7%25D9%2584%25D9%2585%25D8%25B4%25D8%25B1%25D9%2588%25D8%25B9.png": "289946f98405b183711a542c1d86ec15",
"assets/assets/images/alawaly/%25D8%25AA%25D9%2581%25D8%25A7%25D8%25B5%25D9%258A%25D9%2584%2520%25D8%25A7%25D9%2584%25D9%2588%25D8%25AD%25D8%25AF%25D8%25A9.png": "7223f027a285e5790bd77bf84ef22f8c",
"assets/assets/images/alawaly/%25D9%2586%25D8%25AA%25D8%25A7%25D8%25A6%25D8%25AC%2520%25D8%25A7%25D9%2584%25D8%25A8%25D8%25AD%25D8%25AB%2520%25D8%25B9%25D9%2584%25D9%258A%2520%25D8%25A7%25D9%2584%25D8%25AE%25D8%25B1%25D9%258A%25D8%25B7%25D8%25A92.png": "cf2d538c2ddbf22a55c72d270bcc614a",
"assets/assets/images/alawaly/cover.png": "66004bd4550502ebf4088408d59b268f",
"assets/assets/images/alawaly/sign%2520up2.png": "7ebde1dd83cb9042fa82c0aa13b3d78f",
"assets/assets/images/captain_drive/cover.png": "7ce1b925f667609522a991963b9b1d3e",
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
"assets/assets/images/ecommerce/cover.png": "67cbb4d2c44ef419efcdb27fd5ea8e83",
"assets/assets/images/ecommerce/IMG-20250411-WA0088.jpg": "36f4cb450be9c77302e1e87022b6f2f3",
"assets/assets/images/ecommerce/IMG-20250411-WA0090.jpg": "66915d746f5ab1580d0e977c826b4ffb",
"assets/assets/images/ecommerce/IMG-20250411-WA0096.jpg": "cf6eeef827a2ca5ff91903abe004e309",
"assets/assets/images/ecommerce/IMG-20250411-WA0099.jpg": "562ac9b60c5c9fcd1b35314fc848cdfd",
"assets/assets/images/ecommerce/IMG-20250411-WA0101.jpg": "0c91d51e9334ed503dfde22223ee02ba",
"assets/assets/images/ecommerce/IMG-20250411-WA0104.jpg": "391aa0d8c3dac9b7f2b02b47a61f77c7",
"assets/assets/images/fortynine/1.png": "bd68c12733409d8bb5c684e3358a28d7",
"assets/assets/images/fortynine/2.png": "23b8eb486eae25efe00b8000d001867e",
"assets/assets/images/fortynine/3.png": "32feffc9118144fa7d2ad3d44f820764",
"assets/assets/images/fortynine/4.png": "4255b1f154a246df729997991aa6a943",
"assets/assets/images/fortynine/5.png": "0753e4dc7145659e261ddbe954307c04",
"assets/assets/images/fortynine/6.png": "754dce45c96218e498f6c47afcdcb297",
"assets/assets/images/fortynine/7.png": "02891b3edc6067caae1ab879bd9610cc",
"assets/assets/images/fortynine/cover.png": "1e9a7300700c6de09a848624a6d2cdc2",
"assets/assets/images/haj/1.png": "4a14e1ba034abe8977e06f954abe6c60",
"assets/assets/images/haj/2.png": "8d3595bcefdbce563c189cd51c2d6c3f",
"assets/assets/images/haj/3.png": "2797b82015d4b2ca38901ef94801dc38",
"assets/assets/images/haj/4.png": "e738cd48df35abff775fddde4e66f048",
"assets/assets/images/haj/5.png": "87a167ec65d76fa28559eb5d8d8cadbd",
"assets/assets/images/haj/6.png": "a7a41578f1152188572b5d1dac44dd28",
"assets/assets/images/haj/7.png": "0ba1ae29a5b8d4f5b89d43e450f8a85d",
"assets/assets/images/haj/8.png": "b3e885c6c009f707ba1fe0c3f8371faf",
"assets/assets/images/haj/cover.png": "9d49c995f84e4a5ef018c81e474e01b2",
"assets/assets/images/hr/cover.png": "bb8f05ad944a817e4024f54a6e8fc1f4",
"assets/assets/images/hr/Screenshot_1779944642.png": "1477af4e9c415c4e33cb409eab6457eb",
"assets/assets/images/hr/Screenshot_1779944657.png": "73903d5972170278732f725cde42139a",
"assets/assets/images/hr/Screenshot_1779944675.png": "c17cf952e83c14349a02e8476c364a8e",
"assets/assets/images/hr/Screenshot_1779944715.png": "3b6b5f4d990f666277332badf64f3ff7",
"assets/assets/images/hr/Screenshot_1779944727.png": "387eed4d9af259d7802a8be6dd0940cf",
"assets/assets/images/hr/Screenshot_1779944740.png": "04e08077e3f703279a8c5461eb61e55d",
"assets/assets/images/logo/7c1ae715-563b-4455-9465-c93bd935db61.png": "e3a972d154c54b1a8c6f5e1916b72102",
"assets/assets/images/logo/portfolio.svg": "dd49b526322907113025772460535bc7",
"assets/assets/images/my_photo/5564545.png": "eeb6258c885e3684f5e1ad0a871f44a9",
"assets/assets/images/saqqar/Account-Screen.png": "eed13fe04308a1a79bef406752c32193",
"assets/assets/images/saqqar/Anser-Screen.png": "a9962edcb393f24bacb70f919f5336c1",
"assets/assets/images/saqqar/Chats-Screen.png": "719add611ede35746b5e8885fe5c6338",
"assets/assets/images/saqqar/cover.png": "c49df211e4fd0cfdbfb444096c7ea98d",
"assets/assets/images/saqqar/Sign-In-Screen.png": "b9a7d79e3c9c17651cf96f8383e5c002",
"assets/assets/images/vistis/cover.png": "571b445cd66e46db2a3a2339b786e4d1",
"assets/assets/images/vistis/Screenshot_20260528_092028.png": "d54b40231dc45682368ecbfc06509507",
"assets/assets/images/vistis/Screenshot_20260528_092118.png": "370365efec27df267a4a58bd91aaa204",
"assets/assets/images/vistis/Screenshot_20260528_092145.png": "6fef2d259bc58ee4e0c0fe06e9e9608d",
"assets/assets/images/vistis/Screenshot_20260528_092217.png": "6e1e2430f41edb1f7213e75cc6a41958",
"assets/assets/images/vistis/Screenshot_20260528_092349.png": "00c6b2882f9d8e1d9c2aac17d8efce5c",
"assets/FontManifest.json": "c75f7af11fb9919e042ad2ee704db319",
"assets/fonts/MaterialIcons-Regular.otf": "a1b1c359fe050e7bc69babc104427d5e",
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
"flutter_bootstrap.js": "40ef82f86fc547db5e1f9db7a88c1537",
"index.html": "050c9025563b061a79395721cf442365",
"/": "050c9025563b061a79395721cf442365",
"main.dart.js": "8809df3d84a45744ae127d1134a2a116",
"manifest.json": "1573fb785e0f8ba8d18ee88d58cf39bf",
"og-image.png": "6040e63755099657ac912203334dcfc2",
"robots.txt": "7616b79820dbc3d749e64574e51ffbb5",
"sitemap.xml": "9501c05ba2a864f44129dc2fdf0ac8e3",
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
