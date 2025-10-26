const {
    Clipboard,
    Front,
    Hints,
    Normal,
    RUNTIME,
    Visual,
    aceVimMap,
    addSearchAlias,
    cmap,
    getClickableElements,
    imap,
    imapkey,
    iunmap,
    map,
    mapkey,
    readText,
    removeSearchAlias,
    tabOpenLink,
    unmap,
    unmapAllExcept,
    vmapkey,
    vunmap
} = api;

mapkey('<Ctrl-Space>', 'Choose a tab with omnibar', function() {
    api.Front.openOmnibar({type: "Tabs"});
});

// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
map('gt', 'T');

// api.mapkey('gi', 'Hint images', function() {
//   const imgs = Array.from(document.querySelectorAll('img[src]'));
//     api.Hints.create(imgs, function(imageEl) {
//       window.location.href = imageEl.src;
//     });
// });

mapkey("F", "Hint images", function() {
  Hints.create("img", Hints.dispatchMouseClick);
})

mapkey("gf", "Toggle spotify", function() {
  const pause = document.querySelector('[aria-label="Pause"]');
  const play = document.querySelector('[aria-label="Play"]');
  if (play) play.click();
  if (pause) pause.click();
})

// mapkey("gx", 'List all role=button in spotify', function() {
//   const buttons = Array.from(document.querySelectorAll('[role="button"]'));
//   if (buttons.length === 0) {
//     Front.showPopup('No buttons found on this page.');
//     return;
//   }
//
//   if (buttons.length > 0) {
//     Front.showPopup(`Found ${buttons.length} buttons`);
//   }
//
//   function getDeepLabel(el) {
//     let label = '';
//     const walker = document.createTreeWalker(el.parentNode, NodeFilter.SHOW_TEXT, {
//       acceptNode: node => node.nodeValue.trim() ? NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_SKIP
//     });
//     let node;
//     while (( node = walker.nextNode())) {
//       const txt = node.nodeValue.trim();
//       if (txt.length > label.length) label = txt;
//
//       return label;
//     }
//   }
//
//   const items = buttons.map((el) => {
//     const label = el.getAttribute('aria-labelledby') ||
//       el.textContent.trim() ||
//       el.title ||
//       '(no label)';
//     return {
//       title: label,
//       url: label,
//     }
//   });
//
//   Front.openOmnibar({
//     type: "Custom",
//     // title: "Spotify playlists",
//     extra: { title: 'Spotify', items: items, callback: (item) => {
//       Front.showPopup('Yay! Executed from outside');
//     }},
//     // list: items,
//     // extra: {
//     //   prompt: "Playlists",
//     //   onInput: console.log,
//     // },
//     // onSelect: function(item) {
//     //   Front.showPopup('Yay! Got executed mate');
//     // }
//     // onSelect: function(item) {
//     //   item.element.scrollIntoView({ behavior: 'smooth', block: 'center' });
//     //   setTimeout(() => item.element.click(), 100);
//     // }
//   })
// })

mapkey("gx", "Open custom URL selector", function() {
    // Your custom data
    const items = [
        { title: "Lofi Beats", url: "https://open.spotify.com/playlist/xyz" },
        { title: "Focus Mix", url: "https://open.spotify.com/playlist/abc" },
        { title: "Jazz Vibes", url: "https://open.spotify.com/playlist/def" }
    ];

    // Save old handler so we can restore it later
    const oldOnEnter = Omnibar.onEnter;

    // Override the default enter handler
    Omnibar.onEnter = function() {
        const item = Omnibar.list[Omnibar.cursor];
        if (item && item.url) {
            RUNTIME("openLink", { tab: { active: true }, url: item.url });
        } else {
            Front.showPopup("No item selected.");
        }
        // Restore default handler after use
        Omnibar.onEnter = oldOnEnter;
    };

    // Open the omnibar with your custom list
    Front.openOmnibar({
        type: "Urls",
        extra: {
            title: "Custom Links",
            items: items
        }
    });
});

mapkey("F", "Hint images", function() {
  Hints.create("img", Hints.dispatchMouseClick);
})

// function uniqueLinks(els) {
//   const seen = new Set();
//   return Array.from(els).filter(e => {
//     const url = e.href;
//     if (seen.has(url)) return false;
//     seen.add(url);
//     return true;
//   });
// }
//
// api.mapkey('f', 'Open non-duplicate link', () => {
//   const allLinks = document.querySelectorAll('a[href]');
//   const filtered = uniqueLinks(allLinks);
//   Hints.create(filtered, Hints.dispatchMouseClick);
// });

// set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
// click `Save` button to make above settings to take effect.</ctrl-i></ctrl-y>
