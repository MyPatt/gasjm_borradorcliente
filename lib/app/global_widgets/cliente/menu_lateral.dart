import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

import 'package:gasjm/app/routes/app_routes.dart';

//Menú deslizable a la izquierda con opciones del  usuario
class MenuLateral extends StatelessWidget {
  const MenuLateral({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(),
          const SizedBox(
            height: 15,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "User Usuario",
              style: TextStyle(
                  color: AppTheme.blueDark, fontWeight: FontWeight.w500),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "user@usuario.com",
              style: TextStyle(color: Colors.black38),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          _buildDrawerItem(
              icon: Icons.person_outline,
              text: 'Mi cuenta',
              onTap: () =>
                  {Navigator.pushReplacementNamed(context, AppRoutes.inicio)}),
          _buildDrawerItem(
              icon: Icons.message_outlined,
              text: 'Mensajes',
              onTap: () => {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.identificacion)
                  }),
          _buildDrawerItem(
              icon: Icons.settings_outlined,
              text: 'Configuración',
              onTap: () => {
                    Navigator.pushReplacementNamed(context, AppRoutes.ubicacion)
                  }),
          _buildDrawerItem(
              icon: Icons.help_outline,
              text: 'Ayuda',
              onTap: () => {
                    Navigator.pushReplacementNamed(context, AppRoutes.registrar)
                  }),
          _buildDrawerItem(
              icon: Icons.exit_to_app_outlined,
              text: 'Cerrar sesión',
              onTap: () => {
                    Navigator.pushReplacementNamed(context, AppRoutes.registrar)
                  }),
          ListTile(
            title: const Text(
              'v: 1.0.0',
              style: TextStyle(color: Colors.black38),
            ),
            onTap: () {},
          ),
        ],
      ),
    ));
  }
}

Widget _buildDrawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide.none, top: BorderSide.none)),
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 48),
          height: 150,
          decoration: BoxDecoration(
            color: AppTheme.blueBackground,
            border: const Border(bottom: BorderSide.none, top: BorderSide.none),
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            child: CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12.0,
                    child: Icon(
                      Icons.camera_alt,
                      size: 15.0,
                      color: Color(0xFF404040),
                    ),
                  ),
                ),
                radius: 38.0,
                backgroundImage: NetworkImage(
                    'https://i.picsum.photos/id/1005/5760/3840.jpg?hmac=2acSJCOwz9q_dKtDZdSB-OIK1HUcwBeXco_RMMTUgfY'),
              ),
            ),
          ),
        ),
      ]));
}

Widget _buildDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.black38,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.black38),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}
