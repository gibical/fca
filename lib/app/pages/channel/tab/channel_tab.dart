

import 'package:flutter/material.dart';
import 'package:mediaverse/app/pages/channel/widgets/add_channel_card_widget.dart';
import 'package:mediaverse/app/pages/channel/widgets/card_channel_widget.dart';
class ChannelTab extends StatelessWidget {
  const ChannelTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: AddChannelCardWidget(),

        ),
        SliverList.builder(
            itemCount: 4,
            itemBuilder: (context  ,  index){
          
          return CardChannelWidget(title: 'New Channel', date: DateTime.now().toString());
        })
      ],
    );
  }
}
