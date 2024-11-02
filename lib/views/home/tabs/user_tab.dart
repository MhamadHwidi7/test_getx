import 'package:ecommerce_test/core/constants/color_constants.dart';
import 'package:ecommerce_test/core/constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(
                  TextConstants.settingsTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    TextConstants.accountSection,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildAccountCard(theme),
                  const SizedBox(height: 32),
                  Text(
                    TextConstants.settingsSection,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildListTiles(theme),
                ],
              ),
              Text(
                TextConstants.version,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountCard(ThemeData theme) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Get.isDarkMode ? ColorConstants.gray700 : Colors.grey.shade200,
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Get.isDarkMode ? ColorConstants.gray500 : Colors.grey.shade300,
            ),
            child: Icon(
              Icons.person,
              size: 32,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            TextConstants.loginRegister,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTiles(ThemeData theme) {
    return Column(
      children: [
        _buildListTile(
          title: TextConstants.language,
          icon: Icons.language,
          trailing: TextConstants.english,
          color: Colors.orange,
          theme: theme,
          onTap: () {},
        ),
        _buildListTile(
          title: TextConstants.notifications,
          icon: Icons.notifications_outlined,
          color: Colors.blue,
          theme: theme,
          onTap: () {},
        ),
        _buildListTile(
          title: TextConstants.help,
          icon: Icons.help,
          color: Colors.green,
          theme: theme,
          onTap: () {},
        ),
        _buildListTile(
          title: TextConstants.logout,
          icon: Icons.exit_to_app,
          color: Colors.red,
          theme: theme,
          onTap: () {},
        ),
      ],
    );
  }
  Widget _buildListTile({
    required String title,
    required IconData icon,
    String? trailing,
    required Color color,
    required ThemeData theme,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: _buildLeadingIcon(icon, color),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        trailing: trailing != null
            ? _buildTrailing(trailing)
            : Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
      ),
    );
  }

  Widget _buildLeadingIcon(IconData icon, Color color) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.2),
      ),
      child: Icon(icon, color: color),
    );
  }

  Widget _buildTrailing(String trailingText) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          trailingText,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey.shade400,
        ),
      ],
    );
  }
}
