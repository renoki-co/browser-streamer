Browser Streamer
================

Stream a (kiosked) website to a RMTP URL using a Firefox headless browser.

This can be useful if you want to stream a specific website (like conferences rooms or live websites) to RMTP URLs. Project mostly borrowed from [envek/dockerized-browser-streamer](https://github.com/Envek/dockerized-browser-streamer).

## 🚀 Installation

Clone the project:

```bash
git clone git@github.com:renoki-co/browser-streamer.git
```

For production usage, consider using the Docker container or build it from scratch locally:

```bash
docker build . -t browser-streamer
```

## 🙌 Usage

```bash
docker run -it --rm \
    -e "WEBSITE_URL=https://www.youtube.com/watch?v=dQw4w9WgXcQ" \
    -e "RTMP_URL=YOUR_RMTP_URL" \
    -p 5900:5900 \
    quay.io/renokico/browser-streamer:1.0
```

The VNC is available at `localhost:5900`. If you go for production, remove the `-p 5900:5900` exposed port.

## 🤝 Contributing

Please see [CONTRIBUTING](CONTRIBUTING.md) for details.

## 🔒  Security

If you discover any security related issues, please email alex@renoki.org instead of using the issue tracker.

## 🎉 Credits

- [Alex Renoki](https://github.com/rennokki)
- [All Contributors](../../contributors)
