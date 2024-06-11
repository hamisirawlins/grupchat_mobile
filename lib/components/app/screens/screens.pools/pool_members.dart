import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:grupchat/main.dart';
import 'package:grupchat/models/pool_members.dart';
import 'package:grupchat/services/data_service.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/widgets/show_snackbar.dart';

class PoolMembers extends StatefulWidget {
  static const String routeName = '/pool-members';
  final String poolId;
  const PoolMembers({super.key, required this.poolId});

  @override
  State<PoolMembers> createState() => _PoolMembersState();
}

class _PoolMembersState extends State<PoolMembers> {
  final DataService _dataService = DataService();
  bool _isLoading = false;
  List<PoolMember> _members = [];
  List<Contact> _contacts = [];
  Contact? _selectedContact;
  final addMemberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPoolMembers();
  }

  Future<void> _requestContactsPermission() async {
    bool permissionGranted = await FlutterContacts.requestPermission();
    if (permissionGranted) {
      await _loadContacts();
    } else {
      if (mounted)
        showSnackBar(
            context, 'Contacts permission is required to add a member.');
    }
  }

  Future<void> _loadContacts() async {
    try {
      final dynamic contacts =
          await FlutterContacts.getContacts(withProperties: true);
      if (contacts is List<Contact>) {
        setState(() {
          _contacts = contacts;
        });
      } else {
        throw Exception('Failed to retrieve contacts');
      }
    } catch (e) {
      if (mounted) showSnackBar(context, 'Failed to load contacts: $e');
    }
  }

  Future<void> _loadPoolMembers() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final members = await _dataService.getPoolMembers(widget.poolId);
      setState(() {
        _members = members;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) showSnackBar(context, e.toString());
    }
  }

  Future<void> _removeMember(String memberId) async {
    try {
      await _dataService.removeMember(widget.poolId, memberId);
      if (mounted) {
        showSnackBar(context, 'Member removed successfully!');
      }
      await _loadPoolMembers();
    } catch (e) {
      if (mounted) showSnackBar(context, e.toString());
    }
  }

  Future<void> addMember() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        });
    try {
      await _dataService.addMember(
          widget.poolId, _selectedContact!.phones[0].number);
      final newMembers = await _dataService.getPoolMembers(widget.poolId);
      if (mounted) {
        addMemberController.clear();
        Navigator.pop(context);
        showSnackBar(context, 'Member added successfully!');
        setState(() {
          _members = newMembers;
        });
      }
    } catch (e) {
      addMemberController.clear();
      if (mounted) {
        Navigator.pop(context);
        showSnackBar(context, e.toString());
      }
    }
  }

  @override
  void dispose() {
    addMemberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pool Members'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        onPressed: () async {
          await _requestContactsPermission();
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: kPrimaryColor,
                  title: const Text(
                    'Add A New Member',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<Contact>(
                          value: _selectedContact,
                          items: _contacts
                              .map((contact) => DropdownMenuItem(
                                    value: contact,
                                    child: Text(contact.displayName),
                                  ))
                              .toList(),
                          onChanged: (selectedContact) async {
                            setState(() {
                              _selectedContact = selectedContact;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select Contact',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await addMember();
                            Navigator.pop(context);
                          },
                          child: const Text('Add',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                );
              });
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'Add Member',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _members.length,
              itemBuilder: (context, index) {
                final member = _members[index];
                return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.04,
                        vertical: SizeConfig.screenHeight * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: SizeConfig.screenHeight * 0.032,
                          backgroundImage: NetworkImage(member.profileImg),
                        ),
                        member.name != null
                            ? Text(member.name!)
                            : Text(member.email),
                        if (member.role != 'Admin' &&
                            member.userId != supabase.auth.currentUser!.id)
                          GestureDetector(
                            onTap: () {
                              _removeMember(member.userId);
                            },
                            child: Chip(
                              backgroundColor: Colors.red[100],
                              side: const BorderSide(color: Colors.transparent),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: const Text(
                                'Remove',
                                style: TextStyle(color: Colors.red),
                              ),
                              avatar: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          )
                        else if (member.userId == supabase.auth.currentUser!.id)
                          GestureDetector(
                            onTap: () {
                              _removeMember(member.userId);
                            },
                            child: Chip(
                              backgroundColor: Colors.red[100],
                              side: const BorderSide(color: Colors.transparent),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: const Text(
                                'Exit',
                                style: TextStyle(color: Colors.red),
                              ),
                              avatar: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          )
                        else if (member.role == 'Admin')
                          GestureDetector(
                              child: Chip(
                            backgroundColor: Colors.grey[100],
                            side: const BorderSide(color: Colors.transparent),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Text(
                              'Admin',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                          )),
                      ],
                    ));
              },
            ),
    );
  }
}
