import 'package:app/folders/dtos/folder_dto.dart';
import 'package:app/folders/dtos/folder_element_dto.dart';
import 'package:app/user/dtos/user_dto.dart';
import 'package:app/utils/helpers/filter_parameters_dto.dart';

class FolderService {
  Future<List<FolderDto>> getFolders(FilterParametersDto filterParametersDto) {
    Future<void>.delayed(const Duration(seconds: 3));

    return Future<List<FolderDto>>.value(
      <FolderDto>[
        FolderDto('0', 'water', ['sick', 'health', 'unknown'], 100),
        FolderDto('1', 'ground', ['sick', 'health', 'unknown'], 253),
        FolderDto(
            '2', 'plant', ['sick', 'health', 'green', 'blue', 'unknown'], 634),
        FolderDto('3', 'juice', ['fruits', 'no-fruits'], 634),
        FolderDto('4', 'kale',
            ['sick', 'health', 'awdaw', 'dawd', 'dawdaw', 'adw2'], 236),
        FolderDto('5', 'mua', ['sick', 'health', 'dawda'], 327),
        FolderDto('6', 'oar', ['sick', 'health', 'adwdaw'], 431),
        FolderDto('7', 'rpar', ['daw', 'health', 'dawdawda'], 146),
        FolderDto(
            '8',
            'xac',
            [
              'dawdaw',
              'health',
              'dawda',
              'dawd',
              'awd',
              'awd231aw',
              'awda213w',
              'aw2daw',
              'aw3daw',
              'aw2daw'
            ],
            234),
        FolderDto('9', 'qwrt', ['dawd', 'health', 'unknown'], 534),
        FolderDto(
            '10',
            'qar',
            [
              'dawdaw',
              'daw',
              'wadaw',
              'zzzada',
              'cawdvaw',
              'dvawdv',
              'wavdwav',
              'awawdvadaw',
              'awvdawvd',
              'awdawvdaw',
              'awdadvaww',
              'advwd',
              'vdaw',
              'avwdavw',
              'dvawvd'
            ],
            634),
        FolderDto('11', 'adw',
            ['sick', 'awdawd', 'dawda', 'wva', 'daw', 'v', '2', 'awdaw'], 123),
        FolderDto('12', 'dqwdq', ['sick', 'wdawd', 'dawd'], 534),
        FolderDto(
            '13',
            'dqwdq',
            [
              'sick',
              'wdawd',
              'awd',
              'zadaw',
              'vawdaw',
              '1231',
              '2312',
              '213123'
            ],
            485),
        FolderDto('14', 'qwdqw', ['12312', 'wdawd', 'aw'], 412),
        FolderDto('15', 'qdwdq',
            ['daw', 'adawd', 'awdadwa', 'avwd', 'vaw', 'dvawv', 'vawdv'], 134),
        FolderDto('16', 'dqwdq', ['dawdaw', 'health', 'awda'], 654),
        FolderDto('17', 'qwdq', ['dawdaw', 'dawdaw', '2313'], 345),
        FolderDto('18', 'dqwdqw', ['dawdaw', 'healdawdawth', 'unknown'], 234),
      ],
    );
  }

  Future<List<FolderElementDto>> getElementFolder(
      FilterParametersDto filterParametersDto) {
    Future<void>.delayed(const Duration(seconds: 3));

    return Future<List<FolderElementDto>>.value(<FolderElementDto>[
      FolderElementDto(
        '0',
        'QWE',
        'sick',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg',
        DateTime.now(),
        DateTime.now(),
        UserDto('0', 'nick', 'name', 'email@mcom', '+7 902 239 232'),
      )
    ]);
  }
}
