 // Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

// Get Bundle ID: osascript -e 'id of app "SomeApp"'

const BRAVE = { name: 'Brave Browser', profile: 'Default' };
const CHROME = { name: 'Google Chrome', profile: 'Default' };
const GCAL = { name: 'GCal' };
const MEET = { name: 'Google Meet' };

module.exports = {
  options: {
    hideIcon: false,
  },
  defaultBrowser: BRAVE,
  // rewrite: [
  //   {
  //     // https://github.com/johnste/finicky/wiki/Configuration#parameters
  //     match: (params) => finicky.log(JSON.stringify(params, null, "  ")),
  //     url: {
  //       protocol: "https"
  //     }
  //   },
  // ],
  handlers: [
    // Zoom Recordings
    {
      match: ['*.zoom.us/rec/*'],
      browser: BRAVE,
    },
    // Zoom
/**/    {
      match: ['*.zoom.us/*'],
      browser: '/Applications/zoom.us.app',
    },
/**/    // Calendar links
    {
      match: ({ opener }) => opener.bundleId === 'com.apple.iCal',
      browser: GCAL,
    },
    // Calendar links
    {
      match: ['*calendar.google.com/*', '*.ics'],
      browser: GCAL,
    },
    // Meets
    {
      match: ['*meet.google.com/*'],
      browser: MEET,
    },
    // Opscon
    {
      match: [ ({ url }) => url.host === "opscon.smartsheet.com" ],
      browser: CHROME,
    },
  ],
};
