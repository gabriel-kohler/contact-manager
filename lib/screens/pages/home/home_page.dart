import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:project_test/presentation/extensions/string_extensions.dart';
import 'package:project_test/utils/utils.dart';

import '../../errors/errors.dart';
import '../pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.presenter}) : super(key: key);

  final HomePresenter presenter;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    widget.presenter.onInitState();
    tabController = TabController(
      initialIndex: 1,
      length: 2,
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        tabController.animateTo(0);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: HomeDrawer(presenter: widget.presenter),
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                widget.presenter.goToAddContact(tabController);
              },
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: AppColors.primary,
          child: TabBar(
            controller: tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.all(5.0),
            indicatorColor: Colors.white,
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.contacts,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.map,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Builder(builder: (context) {
          widget.presenter.mainError.listen((ScreenError? mainError) {
            if (mainError != null) {
              ScaffoldMessenger
                  .of(context)
                  .showSnackBar(
                SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(mainError.description),
                ),
              )
                  .closed
                  .then(
                    (value) => ScaffoldMessenger.of(context).clearSnackBars(),
              );
            }
          });
          return TabBarView(
            controller: tabController,
            children: [
              HomeContactList(
                presenter: widget.presenter,
              ),
              HomeMap(
                presenter: widget.presenter,
              ),
            ],
          );
        }),
      ),
    );
  }
}

class HomeMap extends StatelessWidget {
  const HomeMap({Key? key, required this.presenter}) : super(key: key);

  final HomePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
              () =>
              FlutterMap(
                options: MapOptions(
                  onMapCreated: presenter.onMapCreated,
                  minZoom: 5,
                  maxZoom: 18,
                  zoom: 13,
                  center: AppConstants.myLocation,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    additionalOptions: {
                      'mapStyleId': AppConstants.mapBoxStyleId,
                      'accessToken': AppConstants.mapBoxAccessToken,
                    },
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(
                    markers: presenter.markers.value,
                  ),
                ],
              ),
        ),
      ],
    );
  }
}

class HomeContactList extends StatelessWidget {
  const HomeContactList({Key? key, required this.presenter}) : super(key: key);

  final HomePresenter presenter;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
            child: Image.asset('assets/images/listcontacts.png'),
          ),
          const SizedBox(
            height: 35,
          ),
          Obx(
                () =>
                Visibility(
                  visible: presenter.contacts.value.isNotEmpty,
                  replacement: const Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child: Center(
                      child: Text(
                        'Nenhum contato adicionado',
                        style: TextStyle(
                          color: AppColors.color1,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  child: SizedBox(
                    height: size.height * 0.5,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: DropdownButton(
                                    iconSize: 0,
                                    hint: const Icon(
                                      Icons.filter_list_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onChanged: (value) {
                                      presenter.onReorder(value!);
                                    },
                                    items: [
                                      'Ordem alfabética',
                                      'Antigos',
                                      'Recentes',
                                    ].map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                  child: Visibility(
                                    visible: presenter.isVisibleTextField.value,
                                    child: Center(
                                      child: TextFormField(
                                        onChanged: presenter.onSearch,
                                        maxLines: 1,
                                        cursorColor: Colors.white,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            hintText: 'Buscar'
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    presenter.isVisibleTextField.value =
                                    !presenter.isVisibleTextField.value;
                                  },
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Obx(() {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: presenter.contacts.value.length,
                              itemBuilder: (context, index) {
                                print('presenter.contacts.value ${presenter.contacts.value.first.name}');
                                final contact = presenter.contacts.value[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: ListTile(
                                    onTap: () {
                                      presenter.goToContactDetailPage(contact);
                                    },
                                    leading: const CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: NetworkImage(
                                        'https://www.promoview.com.br/uploads/images/unnamed%2819%29.png',
                                      ),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    title: Text(contact.name),
                                    subtitle: Text(contact.date.toDateFormat()),
                                  ),
                                );
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key, required this.presenter}) : super(key: key);

  final HomePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Center(
              child: Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              presenter.logout();
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Deletar conta'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(
                        child: Text("Autenticação necessária"),
                      ),
                      content: SizedBox(
                        height: 150,
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Senha",
                              ),
                              obscureText: true,
                              onChanged: presenter.onPasswordSubmitted,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: IconsOutlineButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      text: 'Cancelar',
                                      iconData: Icons.cancel_outlined,
                                      textStyle:
                                      const TextStyle(color: Colors.grey),
                                      iconColor: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        presenter.deleteUser();
                                      },
                                      icon: const Icon(Icons.delete,
                                          color: Colors.white),
                                      label: const Text(
                                        'Deletar',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
