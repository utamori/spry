import { defineConfig } from 'vitepress';

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: 'Spry',
  titleTemplate: 'Spry: :title',
  description:
    'An HTTP middleware framework for Dart to make web applications and APIs server more enjoyable to write.',
  themeConfig: {
    editLink: {
      pattern: ':repo/edit/:branch/:path',
    },
    sidebar: [
      {
        text: 'Getting Started',
        items: [
          { text: 'Introduction', link: '/getting-started/' },
          { text: 'Installation', link: '/getting-started/installation' },
          { text: 'Hello World', link: '/getting-started/hello-world' },
        ],
      },
      {
        text: 'Basics',
        items: [
          { text: 'Routing', link: '/basics/routing' },
          { text: 'Controllers', link: '/basics/controllers' },
        ],
      },
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/medz/spry' },
      {
        icon: 'twitter',
        link: 'https://twitter.com/shiweidu',
      },
    ],
  },
});