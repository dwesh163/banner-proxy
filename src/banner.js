(function () {
    if (document.getElementById('proxy-banner')) return;

    const bannerMessage = window.BANNER_MESSAGE || `Welcome! This is a banner.`;
    const bannerColor = window.BANNER_COLOR || '#d97706';

    const bannerHTML = `
        <div id="proxy-banner" style="position: fixed; top: 0; left: 0; right: 0; z-index: 9999; background-color: ${bannerColor}; color: white; padding: 16px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;">
            <div style="max-width: 1200px; margin: 0 auto; display: flex; align-items: center; justify-content: space-between;">
                <p style="margin: 0; font-weight: 500; flex: 1;" id="banner-message">${bannerMessage}</p>
                <button id="banner-close" style="background: none; border: none; color: white; cursor: pointer; padding: 8px; margin-left: 16px; border-radius: 4px; display: flex; align-items: center; justify-content: center;" onmouseover="this.style.backgroundColor='rgba(0,0,0,0.1)'" onmouseout="this.style.backgroundColor='transparent'">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M18 6 6 18"/><path d="m6 6 12 12"/>
                    </svg>
                </button>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('afterbegin', bannerHTML);
    document.body.style.paddingTop = '60px';

    document.getElementById('banner-close').onclick = function () {
        document.getElementById('proxy-banner').style.display = 'none';
        document.body.style.paddingTop = '0';
    };
})();
