import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/error_text.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:reddit_clone/core/utils.dart';
import 'package:reddit_clone/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone/features/community/controller/community_controller.dart';
import 'package:reddit_clone/models/community.dart';

class AddModsScreen extends ConsumerStatefulWidget {
  final String name;
  const AddModsScreen({
    super.key,
    required this.name,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddModsScreenState();
}

class _AddModsScreenState extends ConsumerState<AddModsScreen> {
  Set<String> uids = {};
  int ctr = 0;
  late Community community;
  bool isLoading = true;

  @override
  void initState() {
    ref.read(getCommunityByNameProvider(widget.name)).when(
          data: (comm) {
            community = comm;
            for (var i = 0; i < community.mods.length; i++) {
              uids.add(community.mods[i]);
            }
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );

    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  void addUid(String uid) {
    setState(() {
      uids.add(uid);
    });
  }

  void removeUid(String uid) {
    if (uids.length == 1) {
      showSnackBar(context, "There should be atleast 1 moderator");
    } else {
      setState(() {
        uids.remove(uid);
      });
    }
  }

  void saveMods() {
    ref.read(communityControllerProvider.notifier).addMods(
          widget.name,
          uids.toList(),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: saveMods,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: isLoading
          ? const Loader()
          : ListView.builder(
              itemCount: community.members.length,
              itemBuilder: (BuildContext context, int index) {
                final member = community.members[index];

                return ref.read(getUserDataProvider(member)).when(
                      data: (user) {
                        return CheckboxListTile(
                          value: uids.contains(user.uid),
                          onChanged: (val) {
                            if (val!) {
                              addUid(user.uid);
                            } else {
                              removeUid(user.uid);
                            }
                          },
                          title: Text(user.name),
                        );
                      },
                      error: (error, stackTrace) => ErrorText(
                        error: error.toString(),
                      ),
                      loading: () => const Loader(),
                    );
              },
            ),
      // body: ref.watch(getCommunityByNameProvider(widget.name)).when(
      //       data: (community) => ListView.builder(
      //         itemCount: community.members.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           final member = community.members[index];

      //           return ref.read(getUserDataProvider(member)).when(
      //                 data: (user) {
      //                   if (community.mods.contains(member)) {
      //                     uids.add(member);
      //                   }
      //                   return CheckboxListTile(
      //                     value: uids.contains(user.uid),
      //                     onChanged: (val) {
      //                       if (val!) {
      //                         addUid(user.uid);
      //                       } else {
      //                         removeUid(user.uid);
      //                       }
      //                     },
      //                     title: Text(user.name),
      //                   );
      //                 },
      //                 error: (error, stackTrace) => ErrorText(
      //                   error: error.toString(),
      //                 ),
      //                 loading: () => const Loader(),
      //               );
      //         },
      //       ),
      //       error: (error, stackTrace) => ErrorText(
      //         error: error.toString(),
      //       ),
      //       loading: () => const Loader(),
      //     ),
    );
  }
}
