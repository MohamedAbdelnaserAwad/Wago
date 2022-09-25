import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wago/shared/components/constants.dart';

class DetailsScreen extends StatelessWidget {

  String? title ;
  String? description;
  String? rate;
  String? releaseDate;
  String? banner ;
  String? poster ;

  DetailsScreen({this.title, this.description, this.rate, this.releaseDate,
      this.banner, this.poster });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 270.0,
                        width: double.infinity,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/w500'+banner!,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Image.asset('assets/images/no_image.png'),
                              fit: BoxFit.fill,
                              height: 250.0,
                              width: double.infinity,
                            ),
                            Container(
                              width :200.0,
                              height: 25.0,
                              color: Colors.black45,
                              child: Text(
                                ' ⭐ Rate  '+ rate!,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:15.0 ,
                      ),
                      Text(
                        '${title}',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        '${releaseDate}',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${description}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      CachedNetworkImage(
                        imageUrl: 'https://image.tmdb.org/t/p/w500'+poster!,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset('assets/images/no_image.png'),
                        width: 150.0,
                      ),
                    ],
                  ),
              )]
        ),
      ),
    );
  }
}
