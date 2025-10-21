api.mapkey('<Ctrl-Space>', 'Choose a tab with omnibar', function() {
    api.Front.openOmnibar({type: "Tabs"});
});

// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
api.map('gt', 'T');
api.map('gx', 'T');

api.unmap('<Alt-y>');

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
