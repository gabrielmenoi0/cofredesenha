import 'package:clipboard/clipboard.dart';
import 'package:cofredesenha/data/database.dart';
import 'package:cofredesenha/models/password/BankModel.dart';
import 'package:cofredesenha/models/password/SaveAccaunt.dart';
import 'package:cofredesenha/models/password/socialModel.dart';
import 'package:cofredesenha/src/home/emptyrefund.dart';
import 'package:cofredesenha/src/password/add/addOthers.dart';
import 'package:cofredesenha/src/password/edit/editBank.dart';
import 'package:cofredesenha/src/password/edit/editOthers.dart';
import 'package:cofredesenha/src/password/edit/editSocial.dart';
import 'package:cofredesenha/src/password/view/passwordBank.dart';
import 'package:cofredesenha/src/password/view/passwordOthers.dart';
import 'package:cofredesenha/src/password/view/passwordSocial.dart';
import 'package:cofredesenha/utils/button.dart';
import 'package:cofredesenha/utils/images.dart';
import 'package:cofredesenha/utils/screenUtils.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ViewPassword extends StatefulWidget {
  const ViewPassword({Key? key}) : super(key: key);

  @override
  _ViewPassword createState() => _ViewPassword();
}

class _ViewPassword extends State<ViewPassword> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  final TextEditingController _textControllerSocial = TextEditingController();
  final TextEditingController _textControllerBank = TextEditingController();
  final TextEditingController _textControllerOthers = TextEditingController();

  final DatabaseProvider _dbHelper = DatabaseProvider.db;
  int groupValue = 0;
  final List<SaveAccountModel> searchResultOthers = [];
  final List<BankModel> searchResultBank = [];
  late final List<SocialModel> searchResultSocial = [];
  final List<SocialModel> itemsSocial = [];
  final List<BankModel> itemsBank = [];
  final List<SaveAccountModel> itemsOthers = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight/2),
          child:  Container(
              child: Row(
                children: [Expanded(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: CupertinoSlidingSegmentedControl<int>(
                      backgroundColor: DefaultColors.darkColor2,
                      thumbColor: DefaultColors.secondaryColor,
                      groupValue: groupValue,
                      children: {
                        0: buildSegment("Sociais"),
                        1: buildSegment("Bancárias"),
                        2: buildSegment("Outras"),
                      },
                      onValueChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      },
                    ),
                  ),

                ),
                ],
              )

          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: ()=> refresh(),
          backgroundColor: Colors.white,
          color: DefaultColors.secondaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                groupValue==0?social():
                groupValue==1?bank():
                groupValue==2?others():Container(),
                SizedBox(height: 50)
              ],
            ),
          ),
        ),
      ),
    );
  }



  social(){
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(10),child:searchSocial(),),
        SizedBox(height: 10,),
        FutureBuilder<List<SocialModel>>(
          future: _dbHelper.getSocial(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return DefaultScreenUtils.onLoading();
            }
            // if (snapshot.hasError) {
            // return const Text("Houve um erro ao encontrar dados!");
            // }

            // _items.sort((a,b) => a.createdAt.isAfter(b.createdAt)? -1: 1);

            if (snapshot.data!.isEmpty) {
              return SizedBox(
                height: 300,
                child: emptyRefund(),
              );
            }

            searchResultSocial.clear();

            if(itemsSocial.isEmpty && _textControllerSocial.text.isEmpty){
              searchResultSocial.addAll(snapshot.data!);
            }else{
              searchResultSocial.addAll(itemsSocial);
            }
            if (searchResultSocial.isEmpty) {
              return emptyRefund2();
            }
            return _listSocial(content: searchResultSocial);
          },
        )
      ],
    );
  }

  bank(){
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(10),child:searchBank(),),
        SizedBox(height: 10,),
        FutureBuilder<List<BankModel>>(
          future: _dbHelper.getBank(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return DefaultScreenUtils.onLoading();
            }
            // if (snapshot.hasError) {
            //   return const Text("Houve um erro ao encontrar dados!");
            // }

            // _items.sort((a,b) => a.createdAt.isAfter(b.createdAt)? -1: 1);

            if (snapshot.data!.isEmpty) {
                return Center(
                child: emptyRefund(),
              );            }
            searchResultBank.clear();
            if(itemsBank.isEmpty && _textControllerBank.text.isEmpty){
              searchResultBank.addAll(snapshot.data!);
            }else{
              searchResultBank.addAll(itemsBank);
            }
            if (searchResultBank.isEmpty) {
              return emptyRefund2();
            }
            return _listBank(content: searchResultBank);
          },
        )
      ],
    )
      ;
  }
  others(){
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(10),child:searchOthers(),),
        SizedBox(height: 10,),
        FutureBuilder<List<SaveAccountModel>>(
          future: _dbHelper.getAccount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return DefaultScreenUtils.onLoading();
            }
            // if (snapshot.hasError) {
            //   return const Text("Houve um erro ao encontrar dados!");
            // }

            // _items.sort((a,b) => a.createdAt.isAfter(b.createdAt)? -1: 1);

            if (snapshot.data!.isEmpty) {
              return emptyRefund();
              
            }

            searchResultOthers.clear();
            if(itemsOthers.isEmpty && _textControllerOthers.text.isEmpty){
              searchResultOthers.addAll(snapshot.data!);
            }else{
              searchResultOthers.addAll(itemsOthers);
            }
            if (searchResultOthers.isEmpty) {
              return emptyRefund2();
            }

            return _list(content: searchResultOthers);
          },
        )
      ],
    );
  }

  Widget buildSegment(String text) {
    return Container(
      height: 44,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  refresh(){
    setState(() {
      _textControllerSocial.clear();
      _textControllerBank.clear();
      _textControllerOthers.clear();
    });
  }
  onSearchTextChangedSocial(String text) async {
    var list = searchResultSocial.where((i) => (i.name ?? "").toLowerCase().contains(text.toLowerCase()))
        .toList();

    itemsSocial.clear();
    itemsSocial.addAll(list);


    setState(() {});
  }
  searchSocial() {
    return TextFormField(
      controller: _textControllerSocial,
      textInputAction: TextInputAction.search,
      onChanged: (query) {
        onSearchTextChangedSocial(query);
      },
      decoration: const InputDecoration(
          hintText: "Pesquise a rede social",
          fillColor: DefaultColors.lightColor1,
          filled: true,
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search,color: DefaultColors.secondaryColor,)),
    );
  }
  onSearchTextChangedOthers(String text) async {
    var list = searchResultOthers
        .where(
            (i) => (i.local ?? "").toLowerCase().contains(text.toLowerCase()))
        .toList();

    itemsOthers.clear();
    itemsOthers.addAll(list);

    setState(() {});
  }
  searchOthers() {
    return TextFormField(
      controller: _textControllerOthers,
      textInputAction: TextInputAction.search,
      onChanged: (query) {
        onSearchTextChangedOthers(query);
      },
      decoration: const InputDecoration(
          hintText: "Pesquise ",
          fillColor: DefaultColors.lightColor1,
          filled: true,
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search,color: DefaultColors.secondaryColor,)),
    );
  }
  onSearchTextChangedBank(String text) async {
    var list = searchResultBank
        .where(
            (i) => (i.bank ?? "").toLowerCase().contains(text.toLowerCase()))
        .toList();
     print(itemsBank);
    itemsBank.clear();
    itemsBank.addAll(list);

    setState(() {});
  }
  searchBank() {
    return TextFormField(
      controller: _textControllerBank,
      textInputAction: TextInputAction.search,
      onChanged: (query) {
        onSearchTextChangedBank(query);
      },
      decoration: const InputDecoration(
          hintText: "Pesquise o banco",
          fillColor: DefaultColors.lightColor1,
          filled: true,
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search,color: DefaultColors.secondaryColor,)),
    );
  }

  _listSocial({required List<SocialModel> content}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 10 / 2),
      itemCount:  content.length ,
      itemBuilder: (BuildContext context, int index) {
        SocialModel item = content[index];
        // SocialModel item = content[index];

        return _cardSocial(item);
      },
    );
  }
  _list({required List<SaveAccountModel> content}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 10 / 2),
      itemCount: content.length,
      itemBuilder: (BuildContext context, int index) {
        // SaveAccountModel item = content[index];
        SaveAccountModel item = content[index];

        return _card(item);
      },
    );
  }
  _listBank({required List<BankModel> content}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 10 / 2),
      itemCount: content.length,
      itemBuilder: (BuildContext context, int index) {
        BankModel item = content[index];

        return _cardBank(item);
      },
    );
  }

  _button() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: DefaultButton(
        context: context,
        title: "+ Adicionar conta",
        callback: go,
      ),
    );
  }

  go() async {
    Navigator.pop(context);
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddPassword()));
    if(result == null) return;

    setState(() {

    });
  }

  static Widget closeBottom(BuildContext context,
      {Color? iconColor = Colors.grey}) =>
      Container(
        alignment: Alignment.centerRight,
        child: IconButton(
            icon: Icon(
              Icons.clear,
              color: iconColor,
            ),
            onPressed: () => Navigator.pop(context)),
      );

  static BoxDecoration decorationBottom() =>
      const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14), topRight: Radius.circular(14)));

 
  bottomExludeBank(BuildContext context,BankModel item) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, setState) {
            return Wrap(
              children: [
                Container(
                  decoration: decorationBottom(),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        closeBottom(context),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Atenção!",
                              style: DefaultStyle.textStyle(
                                  size: 24,
                                  fontWeight: FontWeight.w700,
                                  color: DefaultColors.secondaryColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Tem certeza que deseja excluir essa conta?",
                          style: DefaultStyle.textStyle(
                              size: 20,
                              fontWeight: FontWeight.w400,
                              color: DefaultColors.darkColor1),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: DefaultButton(
                                  context: context,
                                  title: "Sim",
                                ),
                                onTap: () => exludeBank(item),
                              ),

                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: DefaultButton(
                                fillColor: DefaultColors.secondaryColor,
                                context: context,
                                title: "Não",
                                callback: () => Navigator.pop(context),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }
  bottomExlude(BuildContext context,SaveAccountModel item) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, setState) {
            return Wrap(
              children: [
                Container(
                  decoration: decorationBottom(),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        closeBottom(context),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Atenção!",
                              style: DefaultStyle.textStyle(
                                  size: 24,
                                  fontWeight: FontWeight.w700,
                                  color: DefaultColors.secondaryColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Tem certeza que deseja excluir essa conta?",
                          style: DefaultStyle.textStyle(
                              size: 20,
                              fontWeight: FontWeight.w400,
                              color: DefaultColors.darkColor1),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: DefaultButton(
                                  context: context,
                                  title: "Sim",
                                ),
                                onTap: () => exlude(item),
                              ),

                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: DefaultButton(
                                fillColor: DefaultColors.secondaryColor,
                                context: context,
                                title: "Não",
                                callback: () => Navigator.pop(context),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }

  _cardSocial(SocialModel item) {
    tap(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordSocial(nome:item.name ,password: item.password,ob: item.ob,type: item.type,id: item.id,model: item,)));
    }
    _copySocial(){
    FlutterClipboard.copy(item.password!).then(( value ) =>
        print('copied'));
    DefaultScreenUtils.onMessage(context: context, message: "Senha copiada para sua Área de transferência!\n", isError: false);
  }
    return Container(
      height: 100,
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: ()=> tap(),
        child: Card(
          shape: RoundedRectangleBorder(
        side: BorderSide(color: DefaultColors.secondaryColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
          elevation: 10,
          child: Padding(padding: EdgeInsets.all(15),
            child: Column(
              children: [
                ListTile(
                  leading: Text("${item.name!}",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: DefaultStyle.textStyle(
                      color: DefaultColors.secondaryColor,
                      fontWeight: FontWeight.w700,
                      size: 18
                  ),),
                  title: Text("${item.type!}",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: DefaultStyle.textStyle(
                      color: DefaultColors.darkColor2,
                      fontWeight: FontWeight.w700,
                      size: 18
                  ),),
                  trailing: IconButton(onPressed: (){_copySocial();}, icon: Icon(Icons.copy,size: 35,)),
                  // GestureDetector(
                  //     onTap: ()=> callbottomSocial(item),
                  //     child: Icon(
                  //       Icons.delete,
                  //       size: 30,
                  //     )
                  // ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     GestureDetector(
                //         onTap: ()=> editSocial(item),
                //         child: Icon(
                //           Icons.edit,
                //           size: 30,
                //         )
                //     ),
                //     GestureDetector(
                //         onTap: ()=> callbottomSocial(item),
                //         child: Icon(
                //           Icons.delete,
                //           size: 30,
                //         )
                //     ),
                //   ],
                // )
              ],
            )
          ),
        ),
      ),
    );
  }

  _cardBank(BankModel item) {
    tap(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordBank(bank:item.bank ,password: item.password,agency: item.agency, accaunt: item.account,id: item.id,model: item,)));
    }
    _copyBank(){
      FlutterClipboard.copy(item.password!).then(( value ) =>
          print('copied'));
      DefaultScreenUtils.onMessage(context: context, message: "Senha copiada para sua Área de transferência!\n", isError: false);
    }
    return Container(
      height: 100,
      margin: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: ()=> tap(),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: DefaultColors.secondaryColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: Padding(padding: EdgeInsets.all(15),
              child: Column(
                children: [
              ListTile(
              leading: Text("${item.bank!}",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: DefaultStyle.textStyle(
                    color: DefaultColors.secondaryColor,
                    fontWeight: FontWeight.w700,
                    size: 18
                ),),
            title: Text("${item.account!}",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: DefaultStyle.textStyle(
                  color: DefaultColors.darkColor2,
                  fontWeight: FontWeight.w700,
                  size: 18
              ),),
            trailing: IconButton(onPressed: (){_copyBank();}, icon: Icon(Icons.copy,size: 35,)),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     GestureDetector(
                  //         onTap: ()=> editSocial(item),
                  //         child: Icon(
                  //           Icons.edit,
                  //           size: 30,
                  //         )
                  //     ),
                  //     GestureDetector(
                  //         onTap: ()=> callbottomSocial(item),
                  //         child: Icon(
                  //           Icons.delete,
                  //           size: 30,
                  //         )
                  //     ),
                  //   ],
                  // )
              ),
                ],
              )
          ),
        ),
      ),
    );
  }
  _card(SaveAccountModel item) {
    tap(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Password(id: item.id,ob: item.observation,pass: item.password,local: item.local, model: item,)));
    }
    _copyOthers(){
      FlutterClipboard.copy(item.password!).then(( value ) =>
          print('copied'));
      DefaultScreenUtils.onMessage(context: context, message: "Senha copiada para sua Área de transferência!\n", isError: false);
    }
    return Container(
      height: 100,
      margin: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: ()=> tap(),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: DefaultColors.secondaryColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: Padding(padding: EdgeInsets.all(15),
              child: Column(
                children: [
              ListTile(
              leading: Text("${item.local ?? " "}",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: DefaultStyle.textStyle(
                    color: DefaultColors.secondaryColor,
                    fontWeight: FontWeight.w700,
                    size: 18
                ),),
            title: Text("${item.observation ?? " "}",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: DefaultStyle.textStyle(
                  color: DefaultColors.darkColor2,
                  fontWeight: FontWeight.w700,
                  size: 18
              ),),
            trailing: IconButton(onPressed: (){_copyOthers();}, icon: Icon(Icons.copy,size: 35,)),
              )],
              )
          ),
        ),
      ),
    );
  }


  editSocial(SocialModel item){
   var result = Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditSocial(nome:item.name ,password: item.password,ob: item.ob,type: item.type,id: item.id,)));
    if(result == null) return;

    setState(() {

    });
  }

  // selectbill(SaveAccountModel item){
  //   Navigator.of(context).pop(item);
  //   print(item);
  // }


  editBank(BankModel model){
    var result = Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => EditBank(accaunt: model.account,agency: model.agency,bank: model.bank,password: model.password,type: model.type,id: model.id,)), (route) => false);
    if(result == null) return;

    setState(() {

    });
  }
  callbottomBank(BankModel item){
    return bottomExludeBank(context, item);
  }

  exludeBank(BankModel item) async {

    var auth = await _dbHelper.deleteBank(item);
    Navigator.pop(context);
    setState(() {

    });
  }
  edit(SaveAccountModel model){
    var result = Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => EditPassword(local: model.local,pass: model.password,ob: model.observation,id: model.id,)), (route) => false);
    if(result == null) return;

    setState(() {

    });
  }
  callbottom(SaveAccountModel item){
    return bottomExlude(context, item);
  }
  // selectbill(SaveAccountModel item){
  //   Navigator.of(context).pop(item);
  //   print(item);
  // }
  exlude(SaveAccountModel item) async {

    var auth = await _dbHelper.deleteAccount(item);
    Navigator.pop(context);
    setState(() {

    });
  }
  emptyRefund2() {
    return Center(
      child: SizedBox(
        height: 450,
        child: Column(
          children: [
            Center(
                child: Image.asset(
                  DefaultAssets.emptyDependents,
                  height: 250,
                )),
            // SizedBox(height: 250,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nenhuma senha encontrada!",
                  style: DefaultStyle.textStyle(
                      fontWeight: FontWeight.w700,
                      color: DefaultColors.darkColor2,
                      size: 24),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }


  emptyRefund() {
    return Center(
      child: SizedBox(
        height: 450,
        child: Column(
          children: [
            Center(
                child: Image.asset(
                  DefaultAssets.emptyDependents,
                  height: 250,
                )),
            // SizedBox(height: 250,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nenhuma senha cadastrada!",
                  style: DefaultStyle.textStyle(
                      fontWeight: FontWeight.w700,
                      color: DefaultColors.darkColor2,
                      size: 24),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
