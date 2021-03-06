// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: hqyIECBaseSetting.proto

#ifndef PROTOBUF_hqyIECBaseSetting_2eproto__INCLUDED
#define PROTOBUF_hqyIECBaseSetting_2eproto__INCLUDED

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
namespace hqyIECBaseSetting {
class BaseSetting;
class BaseSettingDefaultTypeInternal;
extern BaseSettingDefaultTypeInternal _BaseSetting_default_instance_;
class Ratio;
class RatioDefaultTypeInternal;
extern RatioDefaultTypeInternal _Ratio_default_instance_;
}  // namespace hqyIECBaseSetting

namespace hqyIECBaseSetting {

namespace protobuf_hqyIECBaseSetting_2eproto {
// Internal implementation detail -- do not call these.
struct TableStruct {
  static const ::google::protobuf::uint32 offsets[];
  static void InitDefaultsImpl();
  static void Shutdown();
};
void AddDescriptors();
void InitDefaults();
}  // namespace protobuf_hqyIECBaseSetting_2eproto

enum BCodeType {
  bcodetype_Positive = 0,
  bcodetype_negtive = 1,
  bcodetype_1588 = 2,
  BCodeType_INT_MIN_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32min,
  BCodeType_INT_MAX_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32max
};
bool BCodeType_IsValid(int value);
const BCodeType BCodeType_MIN = bcodetype_Positive;
const BCodeType BCodeType_MAX = bcodetype_1588;
const int BCodeType_ARRAYSIZE = BCodeType_MAX + 1;

const ::google::protobuf::EnumDescriptor* BCodeType_descriptor();
inline const ::std::string& BCodeType_Name(BCodeType value) {
  return ::google::protobuf::internal::NameOfEnum(
    BCodeType_descriptor(), value);
}
inline bool BCodeType_Parse(
    const ::std::string& name, BCodeType* value) {
  return ::google::protobuf::internal::ParseNamedEnum<BCodeType>(
    BCodeType_descriptor(), name, value);
}
// ===================================================================

class BaseSetting : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:hqyIECBaseSetting.BaseSetting) */ {
 public:
  BaseSetting();
  virtual ~BaseSetting();

  BaseSetting(const BaseSetting& from);

  inline BaseSetting& operator=(const BaseSetting& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const BaseSetting& default_instance();

  static inline const BaseSetting* internal_default_instance() {
    return reinterpret_cast<const BaseSetting*>(
               &_BaseSetting_default_instance_);
  }

  void Swap(BaseSetting* other);

  // implements Message ----------------------------------------------

  inline BaseSetting* New() const PROTOBUF_FINAL { return New(NULL); }

  BaseSetting* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const BaseSetting& from);
  void MergeFrom(const BaseSetting& from);
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
  void InternalSwap(BaseSetting* other);
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

  // repeated .hqyIECBaseSetting.Ratio oratio = 5;
  int oratio_size() const;
  void clear_oratio();
  static const int kOratioFieldNumber = 5;
  const ::hqyIECBaseSetting::Ratio& oratio(int index) const;
  ::hqyIECBaseSetting::Ratio* mutable_oratio(int index);
  ::hqyIECBaseSetting::Ratio* add_oratio();
  ::google::protobuf::RepeatedPtrField< ::hqyIECBaseSetting::Ratio >*
      mutable_oratio();
  const ::google::protobuf::RepeatedPtrField< ::hqyIECBaseSetting::Ratio >&
      oratio() const;

  // float fFreN = 1;
  void clear_ffren();
  static const int kFFreNFieldNumber = 1;
  float ffren() const;
  void set_ffren(float value);

  // float fUn = 2;
  void clear_fun();
  static const int kFUnFieldNumber = 2;
  float fun() const;
  void set_fun(float value);

  // float fIn = 3;
  void clear_fin();
  static const int kFInFieldNumber = 3;
  float fin() const;
  void set_fin(float value);

  // .hqyIECBaseSetting.BCodeType bcodetype = 4;
  void clear_bcodetype();
  static const int kBcodetypeFieldNumber = 4;
  ::hqyIECBaseSetting::BCodeType bcodetype() const;
  void set_bcodetype(::hqyIECBaseSetting::BCodeType value);

  // bool bSendzero = 6;
  void clear_bsendzero();
  static const int kBSendzeroFieldNumber = 6;
  bool bsendzero() const;
  void set_bsendzero(bool value);

  // @@protoc_insertion_point(class_scope:hqyIECBaseSetting.BaseSetting)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::RepeatedPtrField< ::hqyIECBaseSetting::Ratio > oratio_;
  float ffren_;
  float fun_;
  float fin_;
  int bcodetype_;
  bool bsendzero_;
  mutable int _cached_size_;
  friend struct  protobuf_hqyIECBaseSetting_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class Ratio : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:hqyIECBaseSetting.Ratio) */ {
 public:
  Ratio();
  virtual ~Ratio();

  Ratio(const Ratio& from);

  inline Ratio& operator=(const Ratio& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const Ratio& default_instance();

  static inline const Ratio* internal_default_instance() {
    return reinterpret_cast<const Ratio*>(
               &_Ratio_default_instance_);
  }

  void Swap(Ratio* other);

  // implements Message ----------------------------------------------

  inline Ratio* New() const PROTOBUF_FINAL { return New(NULL); }

  Ratio* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const Ratio& from);
  void MergeFrom(const Ratio& from);
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
  void InternalSwap(Ratio* other);
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

  // uint32 nprimaryvolte = 1;
  void clear_nprimaryvolte();
  static const int kNprimaryvolteFieldNumber = 1;
  ::google::protobuf::uint32 nprimaryvolte() const;
  void set_nprimaryvolte(::google::protobuf::uint32 value);

  // uint32 nsecondaryvolte = 2;
  void clear_nsecondaryvolte();
  static const int kNsecondaryvolteFieldNumber = 2;
  ::google::protobuf::uint32 nsecondaryvolte() const;
  void set_nsecondaryvolte(::google::protobuf::uint32 value);

  // uint32 nprimarycurrent = 3;
  void clear_nprimarycurrent();
  static const int kNprimarycurrentFieldNumber = 3;
  ::google::protobuf::uint32 nprimarycurrent() const;
  void set_nprimarycurrent(::google::protobuf::uint32 value);

  // uint32 nsecondarycurrent = 4;
  void clear_nsecondarycurrent();
  static const int kNsecondarycurrentFieldNumber = 4;
  ::google::protobuf::uint32 nsecondarycurrent() const;
  void set_nsecondarycurrent(::google::protobuf::uint32 value);

  // @@protoc_insertion_point(class_scope:hqyIECBaseSetting.Ratio)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::uint32 nprimaryvolte_;
  ::google::protobuf::uint32 nsecondaryvolte_;
  ::google::protobuf::uint32 nprimarycurrent_;
  ::google::protobuf::uint32 nsecondarycurrent_;
  mutable int _cached_size_;
  friend struct  protobuf_hqyIECBaseSetting_2eproto::TableStruct;
};
// ===================================================================


// ===================================================================

#if !PROTOBUF_INLINE_NOT_IN_HEADERS
// BaseSetting

// float fFreN = 1;
inline void BaseSetting::clear_ffren() {
  ffren_ = 0;
}
inline float BaseSetting::ffren() const {
  // @@protoc_insertion_point(field_get:hqyIECBaseSetting.BaseSetting.fFreN)
  return ffren_;
}
inline void BaseSetting::set_ffren(float value) {
  
  ffren_ = value;
  // @@protoc_insertion_point(field_set:hqyIECBaseSetting.BaseSetting.fFreN)
}

// float fUn = 2;
inline void BaseSetting::clear_fun() {
  fun_ = 0;
}
inline float BaseSetting::fun() const {
  // @@protoc_insertion_point(field_get:hqyIECBaseSetting.BaseSetting.fUn)
  return fun_;
}
inline void BaseSetting::set_fun(float value) {
  
  fun_ = value;
  // @@protoc_insertion_point(field_set:hqyIECBaseSetting.BaseSetting.fUn)
}

// float fIn = 3;
inline void BaseSetting::clear_fin() {
  fin_ = 0;
}
inline float BaseSetting::fin() const {
  // @@protoc_insertion_point(field_get:hqyIECBaseSetting.BaseSetting.fIn)
  return fin_;
}
inline void BaseSetting::set_fin(float value) {
  
  fin_ = value;
  // @@protoc_insertion_point(field_set:hqyIECBaseSetting.BaseSetting.fIn)
}

// .hqyIECBaseSetting.BCodeType bcodetype = 4;
inline void BaseSetting::clear_bcodetype() {
  bcodetype_ = 0;
}
inline ::hqyIECBaseSetting::BCodeType BaseSetting::bcodetype() const {
  // @@protoc_insertion_point(field_get:hqyIECBaseSetting.BaseSetting.bcodetype)
  return static_cast< ::hqyIECBaseSetting::BCodeType >(bcodetype_);
}
inline void BaseSetting::set_bcodetype(::hqyIECBaseSetting::BCodeType value) {
  
  bcodetype_ = value;
  // @@protoc_insertion_point(field_set:hqyIECBaseSetting.BaseSetting.bcodetype)
}

// repeated .hqyIECBaseSetting.Ratio oratio = 5;
inline int BaseSetting::oratio_size() const {
  return oratio_.size();
}
inline void BaseSetting::clear_oratio() {
  oratio_.Clear();
}
inline const ::hqyIECBaseSetting::Ratio& BaseSetting::oratio(int index) const {
  // @@protoc_insertion_point(field_get:hqyIECBaseSetting.BaseSetting.oratio)
  return oratio_.Get(index);
}
inline ::hqyIECBaseSetting::Ratio* BaseSetting::mutable_oratio(int index) {
  // @@protoc_insertion_point(field_mutable:hqyIECBaseSetting.BaseSetting.oratio)
  return oratio_.Mutable(index);
}
inline ::hqyIECBaseSetting::Ratio* BaseSetting::add_oratio() {
  // @@protoc_insertion_point(field_add:hqyIECBaseSetting.BaseSetting.oratio)
  return oratio_.Add();
}
inline ::google::protobuf::RepeatedPtrField< ::hqyIECBaseSetting::Ratio >*
BaseSetting::mutable_oratio() {
  // @@protoc_insertion_point(field_mutable_list:hqyIECBaseSetting.BaseSetting.oratio)
  return &oratio_;
}
inline const ::google::protobuf::RepeatedPtrField< ::hqyIECBaseSetting::Ratio >&
BaseSetting::oratio() const {
  // @@protoc_insertion_point(field_list:hqyIECBaseSetting.BaseSetting.oratio)
  return oratio_;
}

// bool bSendzero = 6;
inline void BaseSetting::clear_bsendzero() {
  bsendzero_ = false;
}
inline bool BaseSetting::bsendzero() const {
  // @@protoc_insertion_point(field_get:hqyIECBaseSetting.BaseSetting.bSendzero)
  return bsendzero_;
}
inline void BaseSetting::set_bsendzero(bool value) {
  
  bsendzero_ = value;
  // @@protoc_insertion_point(field_set:hqyIECBaseSetting.BaseSetting.bSendzero)
}

// -------------------------------------------------------------------

// Ratio

// uint32 nprimaryvolte = 1;
inline void Ratio::clear_nprimaryvolte() {
  nprimaryvolte_ = 0u;
}
inline ::google::protobuf::uint32 Ratio::nprimaryvolte() const {
  // @@protoc_insertion_point(field_get:hqyIECBaseSetting.Ratio.nprimaryvolte)
  return nprimaryvolte_;
}
inline void Ratio::set_nprimaryvolte(::google::protobuf::uint32 value) {
  
  nprimaryvolte_ = value;
  // @@protoc_insertion_point(field_set:hqyIECBaseSetting.Ratio.nprimaryvolte)
}

// uint32 nsecondaryvolte = 2;
inline void Ratio::clear_nsecondaryvolte() {
  nsecondaryvolte_ = 0u;
}
inline ::google::protobuf::uint32 Ratio::nsecondaryvolte() const {
  // @@protoc_insertion_point(field_get:hqyIECBaseSetting.Ratio.nsecondaryvolte)
  return nsecondaryvolte_;
}
inline void Ratio::set_nsecondaryvolte(::google::protobuf::uint32 value) {
  
  nsecondaryvolte_ = value;
  // @@protoc_insertion_point(field_set:hqyIECBaseSetting.Ratio.nsecondaryvolte)
}

// uint32 nprimarycurrent = 3;
inline void Ratio::clear_nprimarycurrent() {
  nprimarycurrent_ = 0u;
}
inline ::google::protobuf::uint32 Ratio::nprimarycurrent() const {
  // @@protoc_insertion_point(field_get:hqyIECBaseSetting.Ratio.nprimarycurrent)
  return nprimarycurrent_;
}
inline void Ratio::set_nprimarycurrent(::google::protobuf::uint32 value) {
  
  nprimarycurrent_ = value;
  // @@protoc_insertion_point(field_set:hqyIECBaseSetting.Ratio.nprimarycurrent)
}

// uint32 nsecondarycurrent = 4;
inline void Ratio::clear_nsecondarycurrent() {
  nsecondarycurrent_ = 0u;
}
inline ::google::protobuf::uint32 Ratio::nsecondarycurrent() const {
  // @@protoc_insertion_point(field_get:hqyIECBaseSetting.Ratio.nsecondarycurrent)
  return nsecondarycurrent_;
}
inline void Ratio::set_nsecondarycurrent(::google::protobuf::uint32 value) {
  
  nsecondarycurrent_ = value;
  // @@protoc_insertion_point(field_set:hqyIECBaseSetting.Ratio.nsecondarycurrent)
}

#endif  // !PROTOBUF_INLINE_NOT_IN_HEADERS
// -------------------------------------------------------------------


// @@protoc_insertion_point(namespace_scope)


}  // namespace hqyIECBaseSetting

#ifndef SWIG
namespace google {
namespace protobuf {

template <> struct is_proto_enum< ::hqyIECBaseSetting::BCodeType> : ::google::protobuf::internal::true_type {};
template <>
inline const EnumDescriptor* GetEnumDescriptor< ::hqyIECBaseSetting::BCodeType>() {
  return ::hqyIECBaseSetting::BCodeType_descriptor();
}

}  // namespace protobuf
}  // namespace google
#endif  // SWIG

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_hqyIECBaseSetting_2eproto__INCLUDED
