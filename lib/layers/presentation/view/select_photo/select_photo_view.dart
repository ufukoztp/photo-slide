import 'dart:io';

import 'package:appnotion_photo_slide/layers/presentation/bloc/select_photo/select_photo_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:video_player/video_player.dart';

import '../../bloc/select_photo/select_photo_bloc.dart';

class SelectPhotoView extends StatelessWidget {
  const SelectPhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SelectPhotoBloc,SelectPhotoStates>( builder: (context, state) {
       return state.maybeMap(

           noPhoto: (value){
             return const Padding(
               padding: EdgeInsets.all(24.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('Henüz bir fotoğraf seçmemişsiniz! Başlamak için hemen istediğiniz fotoğrafları seçin...')
               ],),
             );
           },
           photoSelectDone: (value){
             return SingleChildScrollView(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   GridView.builder(

                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (BuildContext context, int index) {
                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Image.file(File(value.images[index].path)),
                     );
                   },itemCount:value.images.length,shrinkWrap: true,),
                   SizedBox(
                       width: double.infinity,
                       height: 50,
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                         child: MaterialButton(onPressed: (){
                           context.read<SelectPhotoBloc>().add(SelecPhotoEvent.convertPhotosToVideo);

                         },color: Colors.black,child: const Text('OLUŞTUR',style: TextStyle(color: Colors.white),),),
                       ))

                 ],
               ),
             );
           },
           convertVideoFinish: (value){
             return  Center(
               child:  Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Icon(Icons.done,color: Colors.green,size: 60,),
                   Text('Videonuz başarıyla oluşturuldu...'),
                   Padding(
                     padding: const EdgeInsets.only(top:35.0),
                     child: MaterialButton(onPressed: (){
                       context.read<SelectPhotoBloc>().add(SelecPhotoEvent.noPhoto);
                     },child:Text('TAMAM',style: TextStyle(color: Colors.white),) ,color: Colors.black,),
                   )
                 ],
               ),
             );
           },
           orElse: (){return Container();});
       },),
      bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.black,
          items:const [
        TabItem(icon: Icons.add_a_photo_outlined,),
      ],onTap: (i){
        context.read<SelectPhotoBloc>().add(SelecPhotoEvent.showSelectPhotoPopUp);
      },),
    );
  }
}
