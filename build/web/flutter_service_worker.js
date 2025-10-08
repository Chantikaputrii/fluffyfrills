'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"1favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/AssetManifest.bin": "2e69d75c19f446921899b78b9c64053a",
"assets/AssetManifest.bin.json": "46caad65ebed69dc9a4cb7b28b0d08eb",
"assets/AssetManifest.json": "134bdc860497c722ff5dc8930e93e788",
"assets/assets/image/celanaanak1.jpeg": "bd115125c0348119683fccf79b045b09",
"assets/assets/image/celanaanak2.jpeg": "1e2d9d34f0d40c75deb48168b4011055",
"assets/assets/image/celanaanak3.jpeg": "0c8d49c6805211d4e31f8ccd2ba58636",
"assets/assets/image/celanaanak4.jpeg": "847eabde81b9620018082949f54f6e31",
"assets/assets/image/celanacewe1.jpeg": "76268863789c853fbc008578376f1cb1",
"assets/assets/image/celanacewe2.jpeg": "82fc536b94a7d89f93d2e00142628333",
"assets/assets/image/celanacewe3.jpeg": "07ea2d9b9479edba51b54f9702a434ff",
"assets/assets/image/celanacewe4.jpeg": "9f6bd6b9cd9a547753e066b8710ace2b",
"assets/assets/image/celanacowo1.jpeg": "c30530cefbc03a18cc2db4b289904efb",
"assets/assets/image/celanacowo2.jpeg": "4aa6f9986f4c4c1a5ed5e58e4bba9cdd",
"assets/assets/image/celanacowo3.jpeg": "4aa6f9986f4c4c1a5ed5e58e4bba9cdd",
"assets/assets/image/celanacowo4.jpeg": "43ed0994939307dd1d71ae5c52028809",
"assets/assets/image/dress1.jpeg": "aba313f6e479c3e193133cbd24cec4bf",
"assets/assets/image/dress2.jpeg": "717befd368f4551f80b7a528e59a7b31",
"assets/assets/image/dress3.jpeg": "c8e4a5d49a630bfebf106ec1f5c4bc3e",
"assets/assets/image/dress4.jpeg": "f9a8f3eabab7c58dbfdfe880998135e4",
"assets/assets/image/dress5.jpeg": "2db40ec02cc395b8aa097bf912fffa37",
"assets/assets/image/dressanak1.jpeg": "70d1183cf158e7111baafc4bedf5b613",
"assets/assets/image/dressanak2.jpeg": "b6fdd2704c349d0d239f05fa22548c6a",
"assets/assets/image/dressanak3.jpeg": "cf66983a419b19831f506fc9a0ffc048",
"assets/assets/image/dressanak4.jpeg": "49861e42d662a7338fdf0cabe05cbc76",
"assets/assets/image/dressanak5.jpeg": "ce78f57aeec012ea712c0859a7612993",
"assets/assets/image/jam1.jpeg": "77f5d0edd64f9a841ac40272a83f1d56",
"assets/assets/image/jam2.jpeg": "bcbb94073bf42d2444c8bfec8ea65e9e",
"assets/assets/image/jam3.jpeg": "673d3847eca7dfa765c08dd53996afe2",
"assets/assets/image/jam4.jpeg": "5291b1f4fb8f131811f160a4f7dad831",
"assets/assets/image/kacamata1.jpeg": "d677ba4f6c2e3e4f3b4d3d80476855da",
"assets/assets/image/kacamata2.jpeg": "cf684e22d797094920644eb438eb6fb2",
"assets/assets/image/kacamata3.jpeg": "cb91c00a1db009ee595ee193c4002632",
"assets/assets/image/kacamata4.jpeg": "d362b9e4b1de323bfbd7d8c3c30b3be8",
"assets/assets/image/kategoriaksesoris.jpeg": "6e96b07b73893329d189e3eb1e9fa08e",
"assets/assets/image/kategorianak.jpeg": "30e0aca113fdb5f5a668b68f78cb9a59",
"assets/assets/image/kategoricewe.jpeg": "d08dd45d4c6bf2a15e9fda79c6f8fb9e",
"assets/assets/image/kategoricowo.jpeg": "a7bb6df8868b98e3d569865c26780405",
"assets/assets/image/kemejacewe1.jpeg": "d923566419f12a23a5e854799780f728",
"assets/assets/image/kemejacewe2.jpeg": "8ead7a9cef56e17fe88385ce3bc4fa82",
"assets/assets/image/kemejacewe3.jpeg": "a860f134a069217877fcc56e0e0c8c7a",
"assets/assets/image/kemejacewe4.jpeg": "ede117cd95784c23ed6ea7ade61ddd74",
"assets/assets/image/kemejacewe5.jpeg": "df6d5c628606ff059ac0f7731b97af12",
"assets/assets/image/kemejacowo1.jpeg": "479f32e3f165f1801a2ebf836ef0f6f6",
"assets/assets/image/kemejacowo2.jpeg": "e9ed3d4875b25752206d67541409376c",
"assets/assets/image/kemejacowo3.jpeg": "b0aac5dd279207fac2c48fadad32891b",
"assets/assets/image/kemejacowo4.jpeg": "2ca0179e91f939db8ef00e11ba59435e",
"assets/assets/image/kemejacowo5.jpeg": "e98fbd89e1efb801e5474b9c70e0a6ac",
"assets/assets/image/kemejanak1.jpeg": "835ed773e724643d77eb7a4c729c765e",
"assets/assets/image/kemejanak2.jpeg": "cd9c4c3b4a9c635d5eb819c15e752c90",
"assets/assets/image/kemejanak3.jpeg": "96cb2daf3ff66fec85b9185f193594fc",
"assets/assets/image/kemejanak4.jpeg": "c1cf016d1f34da1860e23a305c69f510",
"assets/assets/image/sepatuanak1.jpeg": "e56ef7980936a9b6522485a53c84dce6",
"assets/assets/image/sepatuanak2.jpeg": "9b8525d7402da461699f345927f1b55e",
"assets/assets/image/sepatuanak3.jpeg": "af97030c1d48023fe4bfdd86679aae73",
"assets/assets/image/sepatuanak4.jpeg": "8f8ccff0057374dee749e33939298180",
"assets/assets/image/sepatucewe1.jpeg": "89c60f5545f3b24c215313d639c99f4e",
"assets/assets/image/sepatucewe2.jpeg": "79f52bf273c13ca425d8823dc47fd28c",
"assets/assets/image/sepatucewe3.jpeg": "f04ab6090d91fba71de4d134c7f3f44b",
"assets/assets/image/sepatucewe4.jpeg": "c5961b56b6ea533c855ff92288139786",
"assets/assets/image/sepatucewe5.jpeg": "8402ac0eeb368f3d75a510cfcb3bc8f2",
"assets/assets/image/sepatucowo1.jpeg": "50fa329dd8c525a9324adb3d65e7639c",
"assets/assets/image/sepatucowo2.jpeg": "810f2fd356d922516573ea0bfde5e616",
"assets/assets/image/sepatucowo3.jpeg": "a7144fcf072072d0ec1b03fd16295b8f",
"assets/assets/image/sepatucowo4.jpeg": "191b804d494573fa67b339cfd3507179",
"assets/assets/image/sepatucowo5.jpeg": "c0fc69a1503072ba8415634917f33b7e",
"assets/assets/image/skirtanak1.jpeg": "ca4cfea58dd6fdfc0e2d66485234c6bf",
"assets/assets/image/skirtanak2.jpeg": "90f7a31e12bb9df79350d990cd46fb6c",
"assets/assets/image/skirtanak3.jpeg": "fb065bccf53a81bfa529c106d5108843",
"assets/assets/image/skirtanak4.jpeg": "f1f1b201557b1a4f088c035c5115b4aa",
"assets/assets/image/skirtcewe1.jpeg": "5cf1a596eba57b0f099671d39c119efd",
"assets/assets/image/skirtcewe2.jpeg": "06b6de2c0b2f4dec73ced790ad847c2b",
"assets/assets/image/skirtcewe3.jpeg": "b620c9e02e529fd42175a3e94519dfbb",
"assets/assets/image/topi1.jpeg": "429d7a274a6028558e4d823ec32e08fa",
"assets/assets/image/topi2.jpeg": "f7cc9ad2b1624717997791079dc3d38c",
"assets/assets/image/topi3.jpeg": "94a4572287c46d63137869a50b233494",
"assets/assets/image/topi4.jpeg": "aac2d6347405029e45ce8b14773af302",
"assets/assets/image/tshirtanak1.jpeg": "a4d240df667b26e56ba401c7ac5a959f",
"assets/assets/image/tshirtanak2.jpeg": "fb77a9893f4210465b8803a63d014e1b",
"assets/assets/image/tshirtanak3.jpeg": "456cd3167dcb862052dc5d96fa0a3470",
"assets/assets/image/tshirtanak4.jpeg": "72589c0eb3a9d59fdd5b2470d576d6f0",
"assets/assets/image/tshirtcewe1.jpeg": "e2d20956a9a65ae238a8407d8f547270",
"assets/assets/image/tshirtcewe2.jpeg": "c2aed6d25776eb95e42d870c67cb0430",
"assets/assets/image/tshirtcewe3.jpeg": "8a4ac883e59329d3ca8d1e3088deec7a",
"assets/assets/image/tshirtcewe4.jpeg": "c16ccc179ec636b08f6d3be8e028bc75",
"assets/assets/image/tshirtcewe5.jpeg": "2bb73f552a72d682dce6ebc68d0e3bfe",
"assets/assets/image/tshirtcowo1.jpeg": "fbde64d8be942d227cb8a7bd3f81cb60",
"assets/assets/image/tshirtcowo2.jpeg": "aed37bf73d10fc81ec935fefd7d7ad1d",
"assets/assets/image/tshirtcowo3.jpeg": "b6ae247704b3e5cb3579c5a8be359008",
"assets/assets/image/tshirtcowo4.jpeg": "d5cb9b1a41cf154d9d28719283be7bd4",
"assets/assets/image/tshirtcowo5.jpeg": "35629899780d185c43300ba7461d3314",
"assets/assets/logo_fashion.png": "65017ba743fefb876baa66121f42ac00",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "deea0f5dba93813bade5621aec9b6b13",
"assets/NOTICES": "07b59fd0a37b8df35a87d5d34c3b5a09",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
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
"favicon.png": "d41d8cd98f00b204e9800998ecf8427e",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "2db46cb69f5688c2acebd04680f5adca",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "becdf31369e6955a806a987b84b66253",
"/": "becdf31369e6955a806a987b84b66253",
"main.dart.js": "3147c5d9a2866faf6dd91ff872395755",
"manifest.json": "bf24c84c3bf99672a631c4f84464e793",
"version.json": "15235b5108d6a877ef74fe3317a96bf7"};
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
