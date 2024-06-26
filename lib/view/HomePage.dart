
import 'package:flutter/material.dart';
import 'package:flutter_assignment/controller/providerclass.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {

  
   void showCountrySelectionModal(BuildContext context) {
    List<Map<String, String>> countries = [
      {"name": "India", "code": "IN"},
      {"name": "United States", "code": "US"},
      {"name": "Australia", "code": "AU"},
      {"name": "Canada", "code": "CA"},
      {"name": "United Kingdom", "code": "GB"},
     
    ];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(countries[index]['name']!),
              onTap: () {
                // setState(() {
                //   selectedCountryName = countries[index]['name']!;
                //   selectedCountryCode = countries[index]['code']!;
                // });
                Provider.of<NewsProvider>(context,listen: false).setSelectedCountryCode(countries[index]['code']!);
                Navigator.pop(context);

              //  fetchNews();
              },
            );
          },
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
     final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 249, 253, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("MyNews",
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color.fromRGBO(255, 255, 255, 1))),
        actions: [
          Row(
            children: [
              SizedBox(
                height: 15,
                width: 15,
                child: Image.asset("assets/images/pic.png"),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 21,
                width: 21,
                child: GestureDetector(
                  onTap: () {
                    showCountrySelectionModal(context);
                  },
                  child: Text("IN",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(245, 249, 253, 1))),
                ),
              ),
            ],
          )
        ],
      ),
      body:  newsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : newsProvider.newsData.isEmpty
              ? const Center(child: Text("No news available"))
              : SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(width: 70,),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: SizedBox(
                height: 21,
                width: 356,
                child: Text("Top Headlines",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(0, 0, 0, 1))),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: newsProvider.newsData.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  height: 146,
                  width: 356,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(255, 255, 255, 1)),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 198,
                            padding: const EdgeInsets.only(left: 12, top: 15),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 21,
                                  width: 198,
                                  child: Text(newsProvider.newsData[index].source?.name ?? '',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 1))),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 63,
                                  width: 198,
                                  child: Text(
                                     newsProvider.newsData[index].description ?? '',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 1))),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 15,
                                  width: 198,
                                  child: Text(newsProvider.newsData[index].publishedAt ?? '',
                                      style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400,
                                          color: const Color.fromRGBO(
                                              206, 211, 220, 1))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    
                      newsProvider.newsData[index].urlToImage != null
                          ? SizedBox(
                              height: 199,
                              width: 174,
                              child: Image.network(
                                newsProvider.newsData[index].urlToImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : SizedBox(
                              height: 199,
                              width: 174,
                              child: Image.asset("assets/images/pic2.png"),
                            ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
  

 
}
