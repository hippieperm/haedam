import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import '../../data/models/item_model.dart';
import '../../../../shared/services/firebase_service.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ItemUploadPage extends ConsumerStatefulWidget {
  const ItemUploadPage({super.key});

  @override
  ConsumerState<ItemUploadPage> createState() => _ItemUploadPageState();
}

class _ItemUploadPageState extends ConsumerState<ItemUploadPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _speciesController = TextEditingController();
  final _styleController = TextEditingController();
  final _heightController = TextEditingController();
  final _crownWidthController = TextEditingController();
  final _ageController = TextEditingController();
  final _healthNotesController = TextEditingController();
  final _originNotesController = TextEditingController();
  final _careHistoryController = TextEditingController();
  final _startPriceController = TextEditingController();
  final _bidStepController = TextEditingController();
  final _reservePriceController = TextEditingController();
  final _buyNowPriceController = TextEditingController();

  String _selectedSizeClass = '소형';
  String _selectedShippingMethod = 'pickup';
  String _selectedFeePolicy = 'buyer';
  DateTime? _auctionStartDate;
  DateTime? _auctionEndDate;
  List<XFile> _selectedImages = [];
  List<Uint8List> _imageBytes = [];
  bool _isLoading = false;

  final List<String> _sizeClasses = ['소형', '중형', '대형', '특대형'];
  final List<String> _shippingMethods = ['pickup', 'courier', 'freight'];
  final List<String> _feePolicies = ['buyer', 'seller', 'split'];

  @override
  void dispose() {
    _titleController.dispose();
    _speciesController.dispose();
    _styleController.dispose();
    _heightController.dispose();
    _crownWidthController.dispose();
    _ageController.dispose();
    _healthNotesController.dispose();
    _originNotesController.dispose();
    _careHistoryController.dispose();
    _startPriceController.dispose();
    _bidStepController.dispose();
    _reservePriceController.dispose();
    _buyNowPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('분재 등록'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 기본 정보 섹션
              _buildSectionTitle('기본 정보'),
              const SizedBox(height: 16),

              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: '제목 *',
                  hintText: '예: 30년생 소나무 분재',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '제목을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _speciesController,
                      decoration: const InputDecoration(
                        labelText: '종류 *',
                        hintText: '예: 소나무',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '종류를 입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _styleController,
                      decoration: const InputDecoration(
                        labelText: '스타일 *',
                        hintText: '예: 직립형',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '스타일을 입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedSizeClass,
                decoration: const InputDecoration(labelText: '크기 분류 *'),
                items: _sizeClasses.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSizeClass = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      decoration: const InputDecoration(
                        labelText: '높이 (cm) *',
                        hintText: '30',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '높이를 입력해주세요';
                        }
                        if (double.tryParse(value) == null) {
                          return '올바른 숫자를 입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _crownWidthController,
                      decoration: const InputDecoration(
                        labelText: '수관폭 (cm) *',
                        hintText: '25',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '수관폭을 입력해주세요';
                        }
                        if (double.tryParse(value) == null) {
                          return '올바른 숫자를 입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: '추정 연령 (년) *',
                  hintText: '30',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '추정 연령을 입력해주세요';
                  }
                  if (int.tryParse(value) == null) {
                    return '올바른 숫자를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // 상세 정보 섹션
              _buildSectionTitle('상세 정보'),
              const SizedBox(height: 16),

              TextFormField(
                controller: _healthNotesController,
                decoration: const InputDecoration(
                  labelText: '건강 상태',
                  hintText: '전반적으로 건강한 상태입니다',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _originNotesController,
                decoration: const InputDecoration(
                  labelText: '출처/기원',
                  hintText: '제주도 야생에서 채취',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _careHistoryController,
                decoration: const InputDecoration(
                  labelText: '관리 이력',
                  hintText: '매년 봄마다 가지치기, 여름철 물주기',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // 이미지 업로드 섹션
              _buildSectionTitle('이미지'),
              const SizedBox(height: 16),

              _buildImageUploadSection(),
              const SizedBox(height: 24),

              // 경매 정보 섹션
              _buildSectionTitle('경매 정보'),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _startPriceController,
                      decoration: const InputDecoration(
                        labelText: '시작가 (원) *',
                        hintText: '100000',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '시작가를 입력해주세요';
                        }
                        if (int.tryParse(value) == null) {
                          return '올바른 숫자를 입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _bidStepController,
                      decoration: const InputDecoration(
                        labelText: '입찰 단위 (원) *',
                        hintText: '10000',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '입찰 단위를 입력해주세요';
                        }
                        if (int.tryParse(value) == null) {
                          return '올바른 숫자를 입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _reservePriceController,
                      decoration: const InputDecoration(
                        labelText: '최저가 (원)',
                        hintText: '500000',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _buyNowPriceController,
                      decoration: const InputDecoration(
                        labelText: '즉시구매가 (원)',
                        hintText: '1000000',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 경매 일정
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _selectAuctionStartDate,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: '경매 시작일 *',
                        ),
                        child: Text(
                          _auctionStartDate != null
                              ? '${_auctionStartDate!.year}-${_auctionStartDate!.month.toString().padLeft(2, '0')}-${_auctionStartDate!.day.toString().padLeft(2, '0')}'
                              : '날짜 선택',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: _selectAuctionEndDate,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: '경매 종료일 *',
                        ),
                        child: Text(
                          _auctionEndDate != null
                              ? '${_auctionEndDate!.year}-${_auctionEndDate!.month.toString().padLeft(2, '0')}-${_auctionEndDate!.day.toString().padLeft(2, '0')}'
                              : '날짜 선택',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 배송 정보 섹션
              _buildSectionTitle('배송 정보'),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedShippingMethod,
                      decoration: const InputDecoration(labelText: '배송 방법 *'),
                      items: [
                        DropdownMenuItem(value: 'pickup', child: Text('직접 픽업')),
                        DropdownMenuItem(value: 'courier', child: Text('택배')),
                        DropdownMenuItem(value: 'freight', child: Text('화물')),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedShippingMethod = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedFeePolicy,
                      decoration: const InputDecoration(labelText: '배송비 부담 *'),
                      items: [
                        DropdownMenuItem(value: 'buyer', child: Text('구매자 부담')),
                        DropdownMenuItem(
                          value: 'seller',
                          child: Text('판매자 부담'),
                        ),
                        DropdownMenuItem(value: 'split', child: Text('분담')),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFeePolicy = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 등록 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitItem,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('분재 등록하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _pickImages,
              icon: const Icon(Icons.add_photo_alternate),
              label: const Text('이미지 추가'),
            ),
            const SizedBox(width: 16),
            Text('${_selectedImages.length}개 선택됨'),
          ],
        ),
        const SizedBox(height: 16),
        if (_selectedImages.isNotEmpty)
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          _imageBytes[index],
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImages.removeAt(index);
                              _imageBytes.removeAt(index);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      final List<Uint8List> bytesList = [];
      for (final image in images) {
        final bytes = await image.readAsBytes();
        bytesList.add(bytes);
      }

      setState(() {
        _selectedImages.addAll(images);
        _imageBytes.addAll(bytesList);
      });
    }
  }

  Future<void> _selectAuctionStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _auctionStartDate = picked;
      });
    }
  }

  Future<void> _selectAuctionEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _auctionStartDate?.add(const Duration(days: 7)) ??
          DateTime.now().add(const Duration(days: 8)),
      firstDate:
          _auctionStartDate ?? DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _auctionEndDate = picked;
      });
    }
  }

  Future<void> _submitItem() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('최소 1개의 이미지를 선택해주세요')));
      return;
    }
    if (_auctionStartDate == null || _auctionEndDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('경매 시작일과 종료일을 선택해주세요')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final currentUser = ref.read(currentUserProvider);
      if (currentUser == null) {
        throw Exception('로그인이 필요합니다');
      }

      // 이미지 업로드
      final List<String> imageUrls = await _uploadImages();

      // 상품 모델 생성
      final item = ItemModel(
        id: '', // Firestore에서 자동 생성
        sellerId: currentUser.uid,
        title: _titleController.text.trim(),
        species: _speciesController.text.trim(),
        style: _styleController.text.trim(),
        sizeClass: _selectedSizeClass,
        heightCm: double.parse(_heightController.text),
        crownWidthCm: double.parse(_crownWidthController.text),
        ageYearsEst: int.parse(_ageController.text),
        healthNotes: _healthNotesController.text.trim().isEmpty
            ? null
            : _healthNotesController.text.trim(),
        originNotes: _originNotesController.text.trim().isEmpty
            ? null
            : _originNotesController.text.trim(),
        careHistory: _careHistoryController.text.trim().isEmpty
            ? null
            : _careHistoryController.text.trim(),
        coverImageUrl: imageUrls.isNotEmpty ? imageUrls.first : '',
        media: imageUrls.asMap().entries.map((entry) {
          return MediaItem(url: entry.value, type: 'image', sort: entry.key);
        }).toList(),
        status: ItemStatus.draft,
        auction: AuctionInfo(
          startPrice: int.parse(_startPriceController.text),
          bidStep: int.parse(_bidStepController.text),
          reservePrice: _reservePriceController.text.isNotEmpty
              ? int.parse(_reservePriceController.text)
              : null,
          buyNowPrice: _buyNowPriceController.text.isNotEmpty
              ? int.parse(_buyNowPriceController.text)
              : null,
          startsAt: _auctionStartDate!,
          endsAt: _auctionEndDate!,
        ),
        shipping: ShippingInfo(
          method: ShippingMethod.values.firstWhere(
            (e) => e.name == _selectedShippingMethod,
          ),
          feePolicy: _selectedFeePolicy,
        ),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Firestore에 저장
      final docRef = await FirebaseService.instance.itemsCollection.add(
        item.toJson(),
      );

      // ID 업데이트
      await docRef.update({'id': docRef.id});

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('분재가 성공적으로 등록되었습니다'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('등록 중 오류가 발생했습니다: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<List<String>> _uploadImages() async {
    final List<String> imageUrls = [];

    for (int i = 0; i < _selectedImages.length; i++) {
      final image = _selectedImages[i];
      final bytes = _imageBytes[i];
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${i}_${image.name}';
      final ref = FirebaseService.instance.itemsStorageRef.child(fileName);

      await ref.putData(bytes);
      final url = await ref.getDownloadURL();
      imageUrls.add(url);
    }

    return imageUrls;
  }
}
