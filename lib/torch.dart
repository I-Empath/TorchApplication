import 'package:flutter/material.dart';
import 'package:flutter_flashlight/flutter_flashlight.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:unity_ads_plugin/unity_ads.dart';
import 'utilities.dart';

class Torch extends StatefulWidget {
  const Torch({Key? key}) : super(key: key);

  @override
  _TorchState createState() => _TorchState();
}

class _TorchState extends State<Torch> {
  late InterstitialAd interstitialAd;

  //Function for loading interstitial ad; if Admob failed, it ll instead show unity Ad
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3733337029898689/8308201090",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            this.interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (error) {
          loadUnityAd();
        },
      ),
    );
    interstitialAd.show();
  }

  //Function for loading interstitial unity Ad.
  void loadUnityAd() {
    UnityAds.showVideoAd(
      placementId: 'Interstitial_Android',
      listener: (state, args) {},
    );
  }

  @override
  void initState() {
    super.initState();

    //initializing unity Ad
    UnityAds.init(
      gameId: "4402731",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              gradientBottomColor,
              gradientTopColor,
            ]),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            isTurnedOn
                ? alignIt = Alignment.bottomCenter
                : alignIt = Alignment.topCenter;
            isTurnedOn = !isTurnedOn;

            isTurnedOn ? Flashlight.lightOn() : Flashlight.lightOff();

            setState(() {
              if (isTurnedOn) {
                gradientTopColor = customOrangeColor;
                trackColor = customOrangeColor;
              } else {
                gradientTopColor = customGreyColor;
                trackColor = trackColorDark;
              }
            });
            loadInterstitialAd();
          },
          child: Container(
            height: 218.0,
            width: 98.0,
            decoration: BoxDecoration(
              color: isTurnedOn ? customOrangeColor : Color(0xFF525151),
              borderRadius: BorderRadius.circular(34.0),
              border: Border.all(
                  color: isTurnedOn ? Color(0xFFa85b2f) : Color(0xFF525151),
                  width: 15.0),
            ),
            child: Align(
              alignment: alignIt,
              child: Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: buttonDarkColor,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 7.0,
                    ),
                  ],
                  color: buttonDarkColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(buttonBottomRadius),
                    top: Radius.circular(buttonTopRadius),
                  ),
                ),
                child: Icon(
                  Icons.vertical_distribute_outlined,
                  color: isTurnedOn ? Colors.greenAccent : Colors.grey[300],
                  size: 30.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
