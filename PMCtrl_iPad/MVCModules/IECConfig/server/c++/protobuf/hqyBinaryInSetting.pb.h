// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: hqyBinaryInSetting.proto

#ifndef PROTOBUF_hqyBinaryInSetting_2eproto__INCLUDED
#define PROTOBUF_hqyBinaryInSetting_2eproto__INCLUDED

#include <string>

#include <google/protobuf/stubs/common.h>

#if GOOGLE_PROTOBUF_VERSION < 3002000
#error This file was generated by a newer version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please update
#error your headers.
#endif
#if 3002000 < GOOGLE_PROTOBUF_MIN_PROTOC_VERSION
#error This file was generated by an older version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please
#error regenerate this file with a newer version of protoc.
#endif

#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/arena.h>
#include <google/protobuf/arenastring.h>
#include <google/protobuf/generated_message_util.h>
#include <google/protobuf/metadata.h>
#include <google/protobuf/message.h>
#include <google/protobuf/repeated_field.h>  // IWYU pragma: export
#include <google/protobuf/extension_set.h>  // IWYU pragma: export
#include <google/protobuf/generated_enum_reflection.h>
#include <google/protobuf/unknown_field_set.h>
// @@protoc_insertion_point(includes)
namespace hqyBinaryInPackage {
class BinaryInInfo;
class BinaryInInfoDefaultTypeInternal;
extern BinaryInInfoDefaultTypeInternal _BinaryInInfo_default_instance_;
class BinaryinSetting;
class BinaryinSettingDefaultTypeInternal;
extern BinaryinSettingDefaultTypeInternal _BinaryinSetting_default_instance_;
}  // namespace hqyBinaryInPackage

namespace hqyBinaryInPackage {

namespace protobuf_hqyBinaryInSetting_2eproto {
// Internal implementation detail -- do not call these.
struct TableStruct {
  static const ::google::protobuf::uint32 offsets[];
  static void InitDefaultsImpl();
  static void Shutdown();
};
void AddDescriptors();
void InitDefaults();
}  // namespace protobuf_hqyBinaryInSetting_2eproto

enum BinaryInType {
  BT_SampleMode = 0,
  BT_EmptyMode = 1,
  BinaryInType_INT_MIN_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32min,
  BinaryInType_INT_MAX_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32max
};
bool BinaryInType_IsValid(int value);
const BinaryInType BinaryInType_MIN = BT_SampleMode;
const BinaryInType BinaryInType_MAX = BT_EmptyMode;
const int BinaryInType_ARRAYSIZE = BinaryInType_MAX + 1;

const ::google::protobuf::EnumDescriptor* BinaryInType_descriptor();
inline const ::std::string& BinaryInType_Name(BinaryInType value) {
  return ::google::protobuf::internal::NameOfEnum(
    BinaryInType_descriptor(), value);
}
inline bool BinaryInType_Parse(
    const ::std::string& name, BinaryInType* value) {
  return ::google::protobuf::internal::ParseNamedEnum<BinaryInType>(
    BinaryInType_descriptor(), name, value);
}
enum BinaryInFD {
  BFD_B_600V = 0,
  BFD_B_100V = 1,
  BFD_B_10V = 2,
  BFD_B_1V = 3,
  BFD_B_01V = 4,
  BinaryInFD_INT_MIN_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32min,
  BinaryInFD_INT_MAX_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32max
};
bool BinaryInFD_IsValid(int value);
const BinaryInFD BinaryInFD_MIN = BFD_B_600V;
const BinaryInFD BinaryInFD_MAX = BFD_B_01V;
const int BinaryInFD_ARRAYSIZE = BinaryInFD_MAX + 1;

const ::google::protobuf::EnumDescriptor* BinaryInFD_descriptor();
inline const ::std::string& BinaryInFD_Name(BinaryInFD value) {
  return ::google::protobuf::internal::NameOfEnum(
    BinaryInFD_descriptor(), value);
}
inline bool BinaryInFD_Parse(
    const ::std::string& name, BinaryInFD* value) {
  return ::google::protobuf::internal::ParseNamedEnum<BinaryInFD>(
    BinaryInFD_descriptor(), name, value);
}
// ===================================================================

class BinaryInInfo : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:hqyBinaryInPackage.BinaryInInfo) */ {
 public:
  BinaryInInfo();
  virtual ~BinaryInInfo();

  BinaryInInfo(const BinaryInInfo& from);

  inline BinaryInInfo& operator=(const BinaryInInfo& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const BinaryInInfo& default_instance();

  static inline const BinaryInInfo* internal_default_instance() {
    return reinterpret_cast<const BinaryInInfo*>(
               &_BinaryInInfo_default_instance_);
  }

  void Swap(BinaryInInfo* other);

  // implements Message ----------------------------------------------

  inline BinaryInInfo* New() const PROTOBUF_FINAL { return New(NULL); }

  BinaryInInfo* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const BinaryInInfo& from);
  void MergeFrom(const BinaryInInfo& from);
  void Clear() PROTOBUF_FINAL;
  bool IsInitialized() const PROTOBUF_FINAL;

  size_t ByteSizeLong() const PROTOBUF_FINAL;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) PROTOBUF_FINAL;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* SerializeWithCachedSizesToArray(::google::protobuf::uint8* output)
      const PROTOBUF_FINAL {
    return InternalSerializeWithCachedSizesToArray(
        ::google::protobuf::io::CodedOutputStream::IsDefaultSerializationDeterministic(), output);
  }
  int GetCachedSize() const PROTOBUF_FINAL { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const PROTOBUF_FINAL;
  void InternalSwap(BinaryInInfo* other);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return NULL;
  }
  inline void* MaybeArenaPtr() const {
    return NULL;
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const PROTOBUF_FINAL;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // .hqyBinaryInPackage.BinaryInType ntype = 1;
  void clear_ntype();
  static const int kNtypeFieldNumber = 1;
  ::hqyBinaryInPackage::BinaryInType ntype() const;
  void set_ntype(::hqyBinaryInPackage::BinaryInType value);

  // float fThreshold = 2;
  void clear_fthreshold();
  static const int kFThresholdFieldNumber = 2;
  float fthreshold() const;
  void set_fthreshold(float value);

  // @@protoc_insertion_point(class_scope:hqyBinaryInPackage.BinaryInInfo)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  int ntype_;
  float fthreshold_;
  mutable int _cached_size_;
  friend struct  protobuf_hqyBinaryInSetting_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class BinaryinSetting : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:hqyBinaryInPackage.BinaryinSetting) */ {
 public:
  BinaryinSetting();
  virtual ~BinaryinSetting();

  BinaryinSetting(const BinaryinSetting& from);

  inline BinaryinSetting& operator=(const BinaryinSetting& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const BinaryinSetting& default_instance();

  static inline const BinaryinSetting* internal_default_instance() {
    return reinterpret_cast<const BinaryinSetting*>(
               &_BinaryinSetting_default_instance_);
  }

  void Swap(BinaryinSetting* other);

  // implements Message ----------------------------------------------

  inline BinaryinSetting* New() const PROTOBUF_FINAL { return New(NULL); }

  BinaryinSetting* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const BinaryinSetting& from);
  void MergeFrom(const BinaryinSetting& from);
  void Clear() PROTOBUF_FINAL;
  bool IsInitialized() const PROTOBUF_FINAL;

  size_t ByteSizeLong() const PROTOBUF_FINAL;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) PROTOBUF_FINAL;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* SerializeWithCachedSizesToArray(::google::protobuf::uint8* output)
      const PROTOBUF_FINAL {
    return InternalSerializeWithCachedSizesToArray(
        ::google::protobuf::io::CodedOutputStream::IsDefaultSerializationDeterministic(), output);
  }
  int GetCachedSize() const PROTOBUF_FINAL { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const PROTOBUF_FINAL;
  void InternalSwap(BinaryinSetting* other);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return NULL;
  }
  inline void* MaybeArenaPtr() const {
    return NULL;
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const PROTOBUF_FINAL;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // repeated .hqyBinaryInPackage.BinaryInInfo oBinaryInfoList = 1;
  int obinaryinfolist_size() const;
  void clear_obinaryinfolist();
  static const int kOBinaryInfoListFieldNumber = 1;
  const ::hqyBinaryInPackage::BinaryInInfo& obinaryinfolist(int index) const;
  ::hqyBinaryInPackage::BinaryInInfo* mutable_obinaryinfolist(int index);
  ::hqyBinaryInPackage::BinaryInInfo* add_obinaryinfolist();
  ::google::protobuf::RepeatedPtrField< ::hqyBinaryInPackage::BinaryInInfo >*
      mutable_obinaryinfolist();
  const ::google::protobuf::RepeatedPtrField< ::hqyBinaryInPackage::BinaryInInfo >&
      obinaryinfolist() const;

  // @@protoc_insertion_point(class_scope:hqyBinaryInPackage.BinaryinSetting)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::RepeatedPtrField< ::hqyBinaryInPackage::BinaryInInfo > obinaryinfolist_;
  mutable int _cached_size_;
  friend struct  protobuf_hqyBinaryInSetting_2eproto::TableStruct;
};
// ===================================================================


// ===================================================================

#if !PROTOBUF_INLINE_NOT_IN_HEADERS
// BinaryInInfo

// .hqyBinaryInPackage.BinaryInType ntype = 1;
inline void BinaryInInfo::clear_ntype() {
  ntype_ = 0;
}
inline ::hqyBinaryInPackage::BinaryInType BinaryInInfo::ntype() const {
  // @@protoc_insertion_point(field_get:hqyBinaryInPackage.BinaryInInfo.ntype)
  return static_cast< ::hqyBinaryInPackage::BinaryInType >(ntype_);
}
inline void BinaryInInfo::set_ntype(::hqyBinaryInPackage::BinaryInType value) {
  
  ntype_ = value;
  // @@protoc_insertion_point(field_set:hqyBinaryInPackage.BinaryInInfo.ntype)
}

// float fThreshold = 2;
inline void BinaryInInfo::clear_fthreshold() {
  fthreshold_ = 0;
}
inline float BinaryInInfo::fthreshold() const {
  // @@protoc_insertion_point(field_get:hqyBinaryInPackage.BinaryInInfo.fThreshold)
  return fthreshold_;
}
inline void BinaryInInfo::set_fthreshold(float value) {
  
  fthreshold_ = value;
  // @@protoc_insertion_point(field_set:hqyBinaryInPackage.BinaryInInfo.fThreshold)
}

// -------------------------------------------------------------------

// BinaryinSetting

// repeated .hqyBinaryInPackage.BinaryInInfo oBinaryInfoList = 1;
inline int BinaryinSetting::obinaryinfolist_size() const {
  return obinaryinfolist_.size();
}
inline void BinaryinSetting::clear_obinaryinfolist() {
  obinaryinfolist_.Clear();
}
inline const ::hqyBinaryInPackage::BinaryInInfo& BinaryinSetting::obinaryinfolist(int index) const {
  // @@protoc_insertion_point(field_get:hqyBinaryInPackage.BinaryinSetting.oBinaryInfoList)
  return obinaryinfolist_.Get(index);
}
inline ::hqyBinaryInPackage::BinaryInInfo* BinaryinSetting::mutable_obinaryinfolist(int index) {
  // @@protoc_insertion_point(field_mutable:hqyBinaryInPackage.BinaryinSetting.oBinaryInfoList)
  return obinaryinfolist_.Mutable(index);
}
inline ::hqyBinaryInPackage::BinaryInInfo* BinaryinSetting::add_obinaryinfolist() {
  // @@protoc_insertion_point(field_add:hqyBinaryInPackage.BinaryinSetting.oBinaryInfoList)
  return obinaryinfolist_.Add();
}
inline ::google::protobuf::RepeatedPtrField< ::hqyBinaryInPackage::BinaryInInfo >*
BinaryinSetting::mutable_obinaryinfolist() {
  // @@protoc_insertion_point(field_mutable_list:hqyBinaryInPackage.BinaryinSetting.oBinaryInfoList)
  return &obinaryinfolist_;
}
inline const ::google::protobuf::RepeatedPtrField< ::hqyBinaryInPackage::BinaryInInfo >&
BinaryinSetting::obinaryinfolist() const {
  // @@protoc_insertion_point(field_list:hqyBinaryInPackage.BinaryinSetting.oBinaryInfoList)
  return obinaryinfolist_;
}

#endif  // !PROTOBUF_INLINE_NOT_IN_HEADERS
// -------------------------------------------------------------------


// @@protoc_insertion_point(namespace_scope)


}  // namespace hqyBinaryInPackage

#ifndef SWIG
namespace google {
namespace protobuf {

template <> struct is_proto_enum< ::hqyBinaryInPackage::BinaryInType> : ::google::protobuf::internal::true_type {};
template <>
inline const EnumDescriptor* GetEnumDescriptor< ::hqyBinaryInPackage::BinaryInType>() {
  return ::hqyBinaryInPackage::BinaryInType_descriptor();
}
template <> struct is_proto_enum< ::hqyBinaryInPackage::BinaryInFD> : ::google::protobuf::internal::true_type {};
template <>
inline const EnumDescriptor* GetEnumDescriptor< ::hqyBinaryInPackage::BinaryInFD>() {
  return ::hqyBinaryInPackage::BinaryInFD_descriptor();
}

}  // namespace protobuf
}  // namespace google
#endif  // SWIG

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_hqyBinaryInSetting_2eproto__INCLUDED