import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class AboutIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info_outline),
      onPressed: () {
        showDialog(
          context: context,
          child: AboutDialog(
            applicationIcon: const Image(
              height: 50,
              width: 50,
              image: AssetImage("assets/app_icon.png"),
            ),
            applicationName: "Wisdom Quotes",
            applicationVersion: "v2.0",
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text("✨ Quotes from"),
                  GestureDetector(
                    onTap: () {
                      _launchURL("https://github.com/lukePeavey/quotable");
                    },
                    child: Text(
                      " Quotable",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: <Widget>[
                  const Text("🖥️ Get the code at"),
                  GestureDetector(
                    onTap: () {
                      _launchURL(
                          "https://github.com/suvansh-rana/wisdom_quotes");
                    },
                    child: Text(
                      " Github",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "✍️ Created by",
                  ),
                  GestureDetector(
                    onTap: () =>
                        _launchURL("https://www.github.com/suvansh-rana"),
                    child: Text(
                      " Suvansh",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "🎁 Thanks to our",
                  ),
                  GestureDetector(
                    onTap: () => _launchURL(
                        "https://github.com/suvansh-rana/wisdom_quotes/graphs/contributors"),
                    child: Text(
                      " contributors !!",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
