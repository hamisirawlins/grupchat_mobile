import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _loadPoolMembers();
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
      setState(() {
        _isLoading = true;
      });

      await _dataService.removeMember(widget.poolId, memberId);
      showSnackBar(context, 'Member removed successfully!');
      await _loadPoolMembers();
    } catch (e) {
      if (mounted) showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Or Remove'),
      ),
      body: _isLoading
          ? Center(
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
                        if (member.role != 'Admin')
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
                        else
                          GestureDetector(
                              onTap: () {
                                _removeMember(member.userId);
                              },
                              child: Chip(
                                backgroundColor: Colors.grey[100],
                                side:
                                    const BorderSide(color: Colors.transparent),
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
