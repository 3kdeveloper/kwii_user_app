import 'package:awii/core/constants/exports.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

dynamic addMoney;

class _WalletPageState extends State<WalletPage> {
  TextEditingController addMoneyController = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController amount = TextEditingController();

  bool _isLoading = true;
  bool _addPayment = false;
  bool _choosePayment = false;
  bool _completed = false;
  bool showtoast = false;
  @override
  void initState() {
    getWallet();
    super.initState();
  }

//get wallet details
  getWallet() async {
    var val = await getWalletHistory();
    if (val == 'success') {
      _isLoading = false;
      _completed = true;
      valueNotifierBook.incrementNotifier();
    }
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "user", child: Text("User")),
      DropdownMenuItem(value: "driver", child: Text("Driver")),
      DropdownMenuItem(value: "owner", child: Text("Owner")),
    ];
    return menuItems;
  }

  showToast() {
    setState(() {
      showtoast = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showtoast = false;
      });
    });
  }

  String dropdownValue = 'user';
  bool error = false;
  String errortext = '';
  bool ispop = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ValueListenableBuilder(
          valueListenable: valueNotifierBook.value,
          builder: (context, value, child) {
            return Directionality(
              textDirection: (languageDirection == 'rtl')
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Scaffold(
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(context.w * 0.05,
                          context.w * 0.05, context.w * 0.05, 0),
                      height: context.h * 1,
                      width: context.w * 1,
                      color: page,
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).padding.top),
                          Stack(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(bottom: context.w * 0.05),
                                width: context.w * 1,
                                alignment: Alignment.center,
                                child: Text(
                                  languages[choosenLanguage]
                                      ['text_enable_wallet'],
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * twenty,
                                      fontWeight: FontWeight.w600,
                                      color: textColor),
                                ),
                              ),
                              Positioned(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.arrow_back)))
                            ],
                          ),
                          SizedBox(
                            height: context.w * 0.05,
                          ),
                          (walletBalance.isNotEmpty)
                              ? Column(
                                  children: [
                                    Text(
                                      languages[choosenLanguage]
                                          ['text_availablebalance'],
                                      style: GoogleFonts.roboto(
                                          fontSize: context.w * twelve,
                                          color: textColor),
                                    ),
                                    SizedBox(
                                      height: context.w * 0.01,
                                    ),
                                    Text(
                                      walletBalance['currency_symbol'] +
                                          walletBalance['wallet_balance']
                                              .toString(),
                                      style: GoogleFonts.roboto(
                                          fontSize: context.w * fourty,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: context.w * 0.05,
                                    ),
                                    Button(
                                      onTap: () {
                                        setState(() {
                                          ispop = true;
                                        });
                                      },
                                      text: languages[choosenLanguage]
                                          ['text_share_money'],
                                      width: context.w * 0.3,
                                    ),
                                    SizedBox(
                                      height: context.w * 0.05,
                                    ),
                                    SizedBox(
                                      width: context.w * 0.9,
                                      child: Text(
                                        languages[choosenLanguage]
                                            ['text_recenttransactions'],
                                        style: GoogleFonts.roboto(
                                            fontSize: context.w * fourteen,
                                            color: textColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          Expanded(
                              child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                (walletHistory.isNotEmpty)
                                    ? Column(
                                        children: walletHistory
                                            .asMap()
                                            .map((i, value) {
                                              return MapEntry(
                                                  i,
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: context.w * 0.02,
                                                        bottom:
                                                            context.w * 0.02),
                                                    width: context.w * 0.9,
                                                    padding: EdgeInsets.all(
                                                        context.w * 0.025),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: borderLines,
                                                            width: 1.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: page),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: context.w *
                                                              0.1067,
                                                          width: context.w *
                                                              0.1067,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: const Color(
                                                                      0xff000000)
                                                                  .withOpacity(
                                                                      0.05)),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            (walletHistory[i][
                                                                        'is_credit'] ==
                                                                    1)
                                                                ? '+'
                                                                : '-',
                                                            style: GoogleFonts.roboto(
                                                                fontSize: context
                                                                        .w *
                                                                    twentyfour,
                                                                color:
                                                                    textColor),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              context.w * 0.025,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              walletHistory[i]
                                                                  ['remarks'],
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: context
                                                                          .w *
                                                                      fourteen,
                                                                  color:
                                                                      textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  context.w *
                                                                      0.01,
                                                            ),
                                                            Text(
                                                              walletHistory[i][
                                                                  'created_at'],
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                fontSize:
                                                                    context.w *
                                                                        ten,
                                                                color:
                                                                    hintColor,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Expanded(
                                                            child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              walletHistory[i][
                                                                      'currency_symbol'] +
                                                                  ' ' +
                                                                  walletHistory[
                                                                              i]
                                                                          [
                                                                          'amount']
                                                                      .toString(),
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                fontSize:
                                                                    context.w *
                                                                        twelve,
                                                                color: const Color(
                                                                    0xffE60000),
                                                              ),
                                                            )
                                                          ],
                                                        ))
                                                      ],
                                                    ),
                                                  ));
                                            })
                                            .values
                                            .toList(),
                                      )
                                    : (_completed == true)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: context.w * 0.05,
                                              ),
                                              Container(
                                                height: context.w * 0.7,
                                                width: context.w * 0.7,
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/nodatafound.gif'),
                                                        fit: BoxFit.contain)),
                                              ),
                                              SizedBox(
                                                height: context.w * 0.02,
                                              ),
                                              SizedBox(
                                                width: context.w * 0.9,
                                                child: Text(
                                                  languages[choosenLanguage]
                                                      ['text_noDataFound'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          context.w * sixteen,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: textColor),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          )
                                        : const SizedBox.shrink(),

                                //load more button
                                (walletPages.isNotEmpty)
                                    ? (walletPages['current_page'] <
                                            walletPages['total_pages'])
                                        ? InkWell(
                                            onTap: () async {
                                              setState(() {
                                                _isLoading = true;
                                              });

                                              await getWalletHistoryPage(
                                                  (walletPages['current_page'] +
                                                          1)
                                                      .toString());

                                              setState(() {
                                                _isLoading = false;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                  context.w * 0.025),
                                              margin: EdgeInsets.only(
                                                  bottom: context.w * 0.05),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: page,
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2)),
                                              child: Text(
                                                languages[choosenLanguage]
                                                    ['text_loadmore'],
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        context.w * sixteen,
                                                    color: textColor),
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink()
                                    : const SizedBox.shrink()
                              ],
                            ),
                          )),

                          //add payment popup
                          (_addPayment == false)
                              ? Container(
                                  padding: EdgeInsets.only(
                                      top: context.w * 0.05,
                                      bottom: context.w * 0.05),
                                  child: Button(
                                      onTap: () {
                                        if (_addPayment == false) {
                                          setState(() {
                                            _addPayment = true;
                                          });
                                        }
                                      },
                                      text: languages[choosenLanguage]
                                          ['text_addmoney']),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),

                    //add payment
                    (_addPayment == true)
                        ? Positioned(
                            bottom: 0,
                            child: Container(
                              height: context.h * 1,
                              width: context.w * 1,
                              color: Colors.transparent.withOpacity(0.6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: context.w * 0.05),
                                    width: context.w * 0.9,
                                    padding: EdgeInsets.all(context.w * 0.025),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: borderLines, width: 1.2),
                                        color: page),
                                    child: Column(children: [
                                      Container(
                                        height: context.w * 0.128,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: borderLines, width: 1.2),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                                width: context.w * 0.1,
                                                height: context.w * 0.128,
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12),
                                                      bottomLeft:
                                                          Radius.circular(12),
                                                    ),
                                                    color: Color(0xffF0F0F0)),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  walletBalance[
                                                      'currency_symbol'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          context.w * fifteen,
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                            SizedBox(
                                              width: context.w * 0.05,
                                            ),
                                            Container(
                                              height: context.w * 0.128,
                                              width: context.w * 0.6,
                                              alignment: Alignment.center,
                                              child: TextField(
                                                controller: addMoneyController,
                                                onChanged: (val) {
                                                  setState(() {
                                                    addMoney = int.parse(val);
                                                  });
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      languages[choosenLanguage]
                                                          ['text_enteramount'],
                                                  hintStyle: GoogleFonts.roboto(
                                                      fontSize:
                                                          context.w * twelve,
                                                      color: hintColor),
                                                ),
                                                maxLines: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: context.w * 0.05,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                addMoneyController.text = '100';
                                                addMoney = 100;
                                              });
                                            },
                                            child: Container(
                                              height: context.w * 0.11,
                                              width: context.w * 0.17,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2),
                                                  color: page,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: Text(
                                                walletBalance[
                                                        'currency_symbol'] +
                                                    '100',
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        context.w * twelve,
                                                    color: textColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: context.w * 0.05,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                addMoneyController.text = '500';
                                                addMoney = 500;
                                              });
                                            },
                                            child: Container(
                                              height: context.w * 0.11,
                                              width: context.w * 0.17,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2),
                                                  color: page,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: Text(
                                                walletBalance[
                                                        'currency_symbol'] +
                                                    '500',
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        context.w * twelve,
                                                    color: textColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: context.w * 0.05,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                addMoneyController.text =
                                                    '1000';
                                                addMoney = 1000;
                                              });
                                            },
                                            child: Container(
                                              height: context.w * 0.11,
                                              width: context.w * 0.17,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2),
                                                  color: page,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: Text(
                                                walletBalance[
                                                        'currency_symbol'] +
                                                    '1000',
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        context.w * twelve,
                                                    color: textColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: context.w * 0.1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Button(
                                            onTap: () async {
                                              setState(() {
                                                _addPayment = false;
                                                addMoney = null;
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                                addMoneyController.clear();
                                              });
                                            },
                                            text: languages[choosenLanguage]
                                                ['text_cancel'],
                                            width: context.w * 0.4,
                                          ),
                                          Button(
                                            onTap: () async {
                                              // print(addMoney);
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              if (addMoney != 0 &&
                                                  addMoney != null) {
                                                setState(() {
                                                  _choosePayment = true;
                                                  _addPayment = false;
                                                });
                                              }
                                            },
                                            text: languages[choosenLanguage]
                                                ['text_addmoney'],
                                            width: context.w * 0.4,
                                          ),
                                        ],
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                            ))
                        : const SizedBox.shrink(),

                    //choose payment method
                    (_choosePayment == true)
                        ? Positioned(
                            child: Container(
                            height: context.h * 1,
                            width: context.w * 1,
                            color: Colors.transparent.withOpacity(0.6),
                            child: SingleChildScrollView(
                              child: SizedBox(
                                height: context.h * 1,
                                width: context.w * 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: context.w * 0.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                _choosePayment = false;
                                                _addPayment = true;
                                              });
                                            },
                                            child: Container(
                                              height: context.h * 0.05,
                                              width: context.h * 0.05,
                                              decoration: BoxDecoration(
                                                color: page,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(Icons.cancel,
                                                  color: buttonColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: context.w * 0.025),
                                    Container(
                                      padding: EdgeInsets.all(context.w * 0.05),
                                      width: context.w * 0.8,
                                      height: context.h * 0.6,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: page),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              width: context.w * 0.7,
                                              child: Text(
                                                languages[choosenLanguage]
                                                    ['text_choose_payment'],
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        context.w * eighteen,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                          SizedBox(
                                            height: context.w * 0.05,
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              child: Column(
                                                children: [
                                                  (walletBalance['stripe'] ==
                                                          true)
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: context
                                                                          .w *
                                                                      0.025),
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              context.w * 0.7,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              var val = await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              SelectWallet()));
                                                              if (val) {
                                                                setState(() {
                                                                  _choosePayment =
                                                                      false;
                                                                  _addPayment =
                                                                      false;
                                                                  addMoney =
                                                                      null;
                                                                  addMoneyController
                                                                      .clear();
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              width: context.w *
                                                                  0.25,
                                                              height:
                                                                  context.w *
                                                                      0.125,
                                                              decoration: const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/images/stripe-icon.png'),
                                                                      fit: BoxFit
                                                                          .contain)),
                                                            ),
                                                          ))
                                                      : const SizedBox.shrink(),
                                                  (walletBalance['paystack'] ==
                                                          true)
                                                      ? Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: context
                                                                          .w *
                                                                      0.025),
                                                          width:
                                                              context.w * 0.7,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              var val = await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              PayStackPage()));
                                                              if (val) {
                                                                setState(() {
                                                                  _choosePayment =
                                                                      false;
                                                                  _addPayment =
                                                                      false;
                                                                  addMoney =
                                                                      null;
                                                                  addMoneyController
                                                                      .clear();
                                                                });
                                                                getWallet();
                                                              }
                                                            },
                                                            child: Container(
                                                              width: context.w *
                                                                  0.25,
                                                              height:
                                                                  context.w *
                                                                      0.125,
                                                              decoration: const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/images/paystack-icon.png'),
                                                                      fit: BoxFit
                                                                          .contain)),
                                                            ),
                                                          ))
                                                      : const SizedBox.shrink(),
                                                  (walletBalance[
                                                              'flutter_wave'] ==
                                                          true)
                                                      ? Container(
                                                          margin: EdgeInsets.only(
                                                              bottom:
                                                                  context.w *
                                                                      0.025),
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              context.w * 0.7,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              var val = await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              FlutterWavePage()));
                                                              if (val) {
                                                                setState(() {
                                                                  _choosePayment =
                                                                      false;
                                                                  _addPayment =
                                                                      false;
                                                                  addMoney =
                                                                      null;
                                                                  addMoneyController
                                                                      .clear();
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              width: context.w *
                                                                  0.25,
                                                              height:
                                                                  context.w *
                                                                      0.125,
                                                              decoration: const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/images/flutterwave-icon.png'),
                                                                      fit: BoxFit
                                                                          .contain)),
                                                            ),
                                                          ))
                                                      : const SizedBox.shrink(),
                                                  (walletBalance['razor_pay'] ==
                                                          true)
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: context
                                                                          .w *
                                                                      0.025),
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              context.w * 0.7,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              var val = await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              RazorPayPage()));
                                                              if (val) {
                                                                setState(() {
                                                                  _choosePayment =
                                                                      false;
                                                                  _addPayment =
                                                                      false;
                                                                  addMoney =
                                                                      null;
                                                                  addMoneyController
                                                                      .clear();
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              width: context.w *
                                                                  0.25,
                                                              height:
                                                                  context.w *
                                                                      0.125,
                                                              decoration: const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/images/razorpay-icon.jpeg'),
                                                                      fit: BoxFit
                                                                          .contain)),
                                                            ),
                                                          ))
                                                      : const SizedBox.shrink(),
                                                  (walletBalance['cash_free'] ==
                                                          true)
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: context
                                                                          .w *
                                                                      0.025),
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              context.w * 0.7,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              var val = await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              CashFreePage()));
                                                              if (val) {
                                                                setState(() {
                                                                  _choosePayment =
                                                                      false;
                                                                  _addPayment =
                                                                      false;
                                                                  addMoney =
                                                                      null;
                                                                  addMoneyController
                                                                      .clear();
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              width: context.w *
                                                                  0.25,
                                                              height:
                                                                  context.w *
                                                                      0.125,
                                                              decoration: const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/images/cashfree-icon.jpeg'),
                                                                      fit: BoxFit
                                                                          .contain)),
                                                            ),
                                                          ))
                                                      : const SizedBox.shrink(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                        : const SizedBox.shrink(),

                    (ispop == true)
                        ? Positioned(
                            top: 0,
                            child: Container(
                              height: context.h * 1,
                              width: context.w * 1,
                              color: Colors.transparent.withOpacity(0.6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(context.w * 0.05),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: page),
                                      width: context.w * 0.8,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: page,
                                              ),
                                              dropdownColor: page,
                                              value: dropdownValue,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownValue = newValue!;
                                                });
                                              },
                                              items: dropdownItems),
                                          InputField(
                                              text: languages[choosenLanguage]
                                                  ['text_enteramount'],
                                              textController: amount,
                                              inputType: TextInputType.number),
                                          // InputField(
                                          //     text: languages[choosenLanguage]
                                          //         ['text_phone_number'],
                                          //     textController: phonenumber,
                                          //     inputType: TextInputType.number),
                                          TextFormField(
                                            controller: phonenumber,
                                            onChanged: (val) {
                                              if (phonenumber.text.length ==
                                                  countries[phcode]
                                                      ['dial_max_length']) {
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              }
                                            },
                                            // maxLength: countries[phcode]
                                            //     ['dial_max_length'],
                                            style: GoogleFonts.roboto(
                                                fontSize: context.w * sixteen,
                                                color: textColor,
                                                letterSpacing: 1),
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText:
                                                  languages[choosenLanguage]
                                                      ['text_phone_number'],
                                              counterText: '',
                                              hintStyle: GoogleFonts.roboto(
                                                  fontSize: context.w * sixteen,
                                                  color: textColor
                                                      .withOpacity(0.7)),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: inputfocusedUnderline,
                                                width: 1.2,
                                                style: BorderStyle.solid,
                                              )),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: inputUnderline,
                                                width: 1.2,
                                                style: BorderStyle.solid,
                                              )),
                                            ),
                                          ),
                                          SizedBox(
                                            height: context.w * 0.05,
                                          ),
                                          error == true
                                              ? Text(
                                                  errortext,
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                )
                                              : const SizedBox.shrink(),
                                          SizedBox(
                                            height: context.w * 0.05,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Button(
                                                  width: context.w * 0.2,
                                                  height: context.w * 0.09,
                                                  onTap: () {
                                                    setState(() {
                                                      ispop = false;
                                                      dropdownValue = 'user';
                                                      error = false;
                                                      errortext = '';
                                                      phonenumber.text = '';
                                                      amount.text = '';
                                                    });
                                                  },
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_close']),
                                              SizedBox(width: context.w * 0.05),
                                              Button(
                                                  width: context.w * 0.2,
                                                  height: context.w * 0.09,
                                                  onTap: () async {
                                                    setState(() {
                                                      _isLoading = true;
                                                    });
                                                    if (phonenumber.text ==
                                                            '' ||
                                                        amount.text == '') {
                                                      setState(() {
                                                        error = true;
                                                        errortext = languages[
                                                                choosenLanguage]
                                                            [
                                                            'text_fill_fileds'];
                                                        _isLoading = false;
                                                      });
                                                    } else {
                                                      var result =
                                                          await sharewalletfun(
                                                              amount:
                                                                  amount.text,
                                                              mobile:
                                                                  phonenumber
                                                                      .text,
                                                              role:
                                                                  dropdownValue);
                                                      if (result == 'success') {
                                                        // navigate();
                                                        setState(() {
                                                          ispop = false;
                                                          dropdownValue =
                                                              'user';
                                                          error = false;
                                                          errortext = '';
                                                          phonenumber.text = '';
                                                          amount.text = '';
                                                          getWallet();
                                                          showToast();
                                                        });
                                                      } else {
                                                        setState(() {
                                                          error = true;
                                                          errortext =
                                                              result.toString();
                                                          _isLoading = false;
                                                        });
                                                      }
                                                    }
                                                  },
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_share']),
                                            ],
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    //no internet
                    (internet == false)
                        ? Positioned(
                            top: 0,
                            child: NoInternet(
                              onTap: () {
                                setState(() {
                                  internetTrue();
                                  // _complete = false;
                                  _isLoading = true;
                                  getWallet();
                                });
                              },
                            ))
                        : const SizedBox.shrink(),

                    //loader
                    (_isLoading == true)
                        ? const Positioned(child: Loading())
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            );
          }),
    );
  }
}
