// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: OutPutCommon.proto

#ifndef PROTOBUF_OutPutCommon_2eproto__INCLUDED
#define PROTOBUF_OutPutCommon_2eproto__INCLUDED

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
namespace OutPutCommon {
class GradientPara;
class GradientParaDefaultTypeInternal;
extern GradientParaDefaultTypeInternal _GradientPara_default_instance_;
class acanalogpara;
class acanalogparaDefaultTypeInternal;
extern acanalogparaDefaultTypeInternal _acanalogpara_default_instance_;
class chanelpara;
class chanelparaDefaultTypeInternal;
extern chanelparaDefaultTypeInternal _chanelpara_default_instance_;
}  // namespace OutPutCommon

namespace OutPutCommon {

namespace protobuf_OutPutCommon_2eproto {
// Internal implementation detail -- do not call these.
struct TableStruct {
  static const ::google::protobuf::uint32 offsets[];
  static void InitDefaultsImpl();
  static void Shutdown();
};
void AddDescriptors();
void InitDefaults();
}  // namespace protobuf_OutPutCommon_2eproto

enum para_type {
  va1_type = 0,
  vb1_type = 1,
  vc1_type = 2,
  vab1_type = 4,
  vbc1_type = 5,
  vca1_type = 6,
  vabc1_type = 7,
  va2_type = 8,
  vb2_type = 9,
  vc2_type = 10,
  vabc2_type = 11,
  ia1_type = 12,
  ib1_type = 13,
  ic1_type = 14,
  iab1_type = 15,
  ibc1_type = 16,
  ica1_type = 17,
  iabc1_type = 18,
  ia2_type = 19,
  ib2_type = 20,
  ic2_type = 21,
  iabc2_type = 22,
  vall_type = 23,
  iall_type = 24,
  vdc_type = 25,
  vz_type = 26,
  para_type_INT_MIN_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32min,
  para_type_INT_MAX_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32max
};
bool para_type_IsValid(int value);
const para_type para_type_MIN = va1_type;
const para_type para_type_MAX = vz_type;
const int para_type_ARRAYSIZE = para_type_MAX + 1;

const ::google::protobuf::EnumDescriptor* para_type_descriptor();
inline const ::std::string& para_type_Name(para_type value) {
  return ::google::protobuf::internal::NameOfEnum(
    para_type_descriptor(), value);
}
inline bool para_type_Parse(
    const ::std::string& name, para_type* value) {
  return ::google::protobuf::internal::ParseNamedEnum<para_type>(
    para_type_descriptor(), name, value);
}
enum changed_type {
  amplitude_type = 0,
  phasor_type = 1,
  fre_type = 2,
  changed_type_INT_MIN_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32min,
  changed_type_INT_MAX_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32max
};
bool changed_type_IsValid(int value);
const changed_type changed_type_MIN = amplitude_type;
const changed_type changed_type_MAX = fre_type;
const int changed_type_ARRAYSIZE = changed_type_MAX + 1;

const ::google::protobuf::EnumDescriptor* changed_type_descriptor();
inline const ::std::string& changed_type_Name(changed_type value) {
  return ::google::protobuf::internal::NameOfEnum(
    changed_type_descriptor(), value);
}
inline bool changed_type_Parse(
    const ::std::string& name, changed_type* value) {
  return ::google::protobuf::internal::ParseNamedEnum<changed_type>(
    changed_type_descriptor(), name, value);
}
// ===================================================================

class GradientPara : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:OutPutCommon.GradientPara) */ {
 public:
  GradientPara();
  virtual ~GradientPara();

  GradientPara(const GradientPara& from);

  inline GradientPara& operator=(const GradientPara& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const GradientPara& default_instance();

  static inline const GradientPara* internal_default_instance() {
    return reinterpret_cast<const GradientPara*>(
               &_GradientPara_default_instance_);
  }

  void Swap(GradientPara* other);

  // implements Message ----------------------------------------------

  inline GradientPara* New() const PROTOBUF_FINAL { return New(NULL); }

  GradientPara* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const GradientPara& from);
  void MergeFrom(const GradientPara& from);
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
  void InternalSwap(GradientPara* other);
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

  // .OutPutCommon.para_type iVar = 1;
  void clear_ivar();
  static const int kIVarFieldNumber = 1;
  ::OutPutCommon::para_type ivar() const;
  void set_ivar(::OutPutCommon::para_type value);

  // .OutPutCommon.changed_type iType = 2;
  void clear_itype();
  static const int kITypeFieldNumber = 2;
  ::OutPutCommon::changed_type itype() const;
  void set_itype(::OutPutCommon::changed_type value);

  // float fStep = 3;
  void clear_fstep();
  static const int kFStepFieldNumber = 3;
  float fstep() const;
  void set_fstep(float value);

  // float fStepTime = 4;
  void clear_fsteptime();
  static const int kFStepTimeFieldNumber = 4;
  float fsteptime() const;
  void set_fsteptime(float value);

  // float fStart = 5;
  void clear_fstart();
  static const int kFStartFieldNumber = 5;
  float fstart() const;
  void set_fstart(float value);

  // float fEnd = 6;
  void clear_fend();
  static const int kFEndFieldNumber = 6;
  float fend() const;
  void set_fend(float value);

  // uint32 nHarm = 7;
  void clear_nharm();
  static const int kNHarmFieldNumber = 7;
  ::google::protobuf::uint32 nharm() const;
  void set_nharm(::google::protobuf::uint32 value);

  // @@protoc_insertion_point(class_scope:OutPutCommon.GradientPara)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  int ivar_;
  int itype_;
  float fstep_;
  float fsteptime_;
  float fstart_;
  float fend_;
  ::google::protobuf::uint32 nharm_;
  mutable int _cached_size_;
  friend struct  protobuf_OutPutCommon_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class chanelpara : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:OutPutCommon.chanelpara) */ {
 public:
  chanelpara();
  virtual ~chanelpara();

  chanelpara(const chanelpara& from);

  inline chanelpara& operator=(const chanelpara& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const chanelpara& default_instance();

  static inline const chanelpara* internal_default_instance() {
    return reinterpret_cast<const chanelpara*>(
               &_chanelpara_default_instance_);
  }

  void Swap(chanelpara* other);

  // implements Message ----------------------------------------------

  inline chanelpara* New() const PROTOBUF_FINAL { return New(NULL); }

  chanelpara* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const chanelpara& from);
  void MergeFrom(const chanelpara& from);
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
  void InternalSwap(chanelpara* other);
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

  // float famptitude = 1;
  void clear_famptitude();
  static const int kFamptitudeFieldNumber = 1;
  float famptitude() const;
  void set_famptitude(float value);

  // float fphase = 2;
  void clear_fphase();
  static const int kFphaseFieldNumber = 2;
  float fphase() const;
  void set_fphase(float value);

  // float ffre = 3;
  void clear_ffre();
  static const int kFfreFieldNumber = 3;
  float ffre() const;
  void set_ffre(float value);

  // @@protoc_insertion_point(class_scope:OutPutCommon.chanelpara)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  float famptitude_;
  float fphase_;
  float ffre_;
  mutable int _cached_size_;
  friend struct  protobuf_OutPutCommon_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class acanalogpara : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:OutPutCommon.acanalogpara) */ {
 public:
  acanalogpara();
  virtual ~acanalogpara();

  acanalogpara(const acanalogpara& from);

  inline acanalogpara& operator=(const acanalogpara& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const acanalogpara& default_instance();

  static inline const acanalogpara* internal_default_instance() {
    return reinterpret_cast<const acanalogpara*>(
               &_acanalogpara_default_instance_);
  }

  void Swap(acanalogpara* other);

  // implements Message ----------------------------------------------

  inline acanalogpara* New() const PROTOBUF_FINAL { return New(NULL); }

  acanalogpara* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const acanalogpara& from);
  void MergeFrom(const acanalogpara& from);
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
  void InternalSwap(acanalogpara* other);
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

  // repeated .OutPutCommon.chanelpara analogcurrentchanelvalue = 1;
  int analogcurrentchanelvalue_size() const;
  void clear_analogcurrentchanelvalue();
  static const int kAnalogcurrentchanelvalueFieldNumber = 1;
  const ::OutPutCommon::chanelpara& analogcurrentchanelvalue(int index) const;
  ::OutPutCommon::chanelpara* mutable_analogcurrentchanelvalue(int index);
  ::OutPutCommon::chanelpara* add_analogcurrentchanelvalue();
  ::google::protobuf::RepeatedPtrField< ::OutPutCommon::chanelpara >*
      mutable_analogcurrentchanelvalue();
  const ::google::protobuf::RepeatedPtrField< ::OutPutCommon::chanelpara >&
      analogcurrentchanelvalue() const;

  // repeated .OutPutCommon.chanelpara analogvoltchangelvalue = 2;
  int analogvoltchangelvalue_size() const;
  void clear_analogvoltchangelvalue();
  static const int kAnalogvoltchangelvalueFieldNumber = 2;
  const ::OutPutCommon::chanelpara& analogvoltchangelvalue(int index) const;
  ::OutPutCommon::chanelpara* mutable_analogvoltchangelvalue(int index);
  ::OutPutCommon::chanelpara* add_analogvoltchangelvalue();
  ::google::protobuf::RepeatedPtrField< ::OutPutCommon::chanelpara >*
      mutable_analogvoltchangelvalue();
  const ::google::protobuf::RepeatedPtrField< ::OutPutCommon::chanelpara >&
      analogvoltchangelvalue() const;

  // @@protoc_insertion_point(class_scope:OutPutCommon.acanalogpara)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::RepeatedPtrField< ::OutPutCommon::chanelpara > analogcurrentchanelvalue_;
  ::google::protobuf::RepeatedPtrField< ::OutPutCommon::chanelpara > analogvoltchangelvalue_;
  mutable int _cached_size_;
  friend struct  protobuf_OutPutCommon_2eproto::TableStruct;
};
// ===================================================================


// ===================================================================

#if !PROTOBUF_INLINE_NOT_IN_HEADERS
// GradientPara

// .OutPutCommon.para_type iVar = 1;
inline void GradientPara::clear_ivar() {
  ivar_ = 0;
}
inline ::OutPutCommon::para_type GradientPara::ivar() const {
  // @@protoc_insertion_point(field_get:OutPutCommon.GradientPara.iVar)
  return static_cast< ::OutPutCommon::para_type >(ivar_);
}
inline void GradientPara::set_ivar(::OutPutCommon::para_type value) {
  
  ivar_ = value;
  // @@protoc_insertion_point(field_set:OutPutCommon.GradientPara.iVar)
}

// .OutPutCommon.changed_type iType = 2;
inline void GradientPara::clear_itype() {
  itype_ = 0;
}
inline ::OutPutCommon::changed_type GradientPara::itype() const {
  // @@protoc_insertion_point(field_get:OutPutCommon.GradientPara.iType)
  return static_cast< ::OutPutCommon::changed_type >(itype_);
}
inline void GradientPara::set_itype(::OutPutCommon::changed_type value) {
  
  itype_ = value;
  // @@protoc_insertion_point(field_set:OutPutCommon.GradientPara.iType)
}

// float fStep = 3;
inline void GradientPara::clear_fstep() {
  fstep_ = 0;
}
inline float GradientPara::fstep() const {
  // @@protoc_insertion_point(field_get:OutPutCommon.GradientPara.fStep)
  return fstep_;
}
inline void GradientPara::set_fstep(float value) {
  
  fstep_ = value;
  // @@protoc_insertion_point(field_set:OutPutCommon.GradientPara.fStep)
}

// float fStepTime = 4;
inline void GradientPara::clear_fsteptime() {
  fsteptime_ = 0;
}
inline float GradientPara::fsteptime() const {
  // @@protoc_insertion_point(field_get:OutPutCommon.GradientPara.fStepTime)
  return fsteptime_;
}
inline void GradientPara::set_fsteptime(float value) {
  
  fsteptime_ = value;
  // @@protoc_insertion_point(field_set:OutPutCommon.GradientPara.fStepTime)
}

// float fStart = 5;
inline void GradientPara::clear_fstart() {
  fstart_ = 0;
}
inline float GradientPara::fstart() const {
  // @@protoc_insertion_point(field_get:OutPutCommon.GradientPara.fStart)
  return fstart_;
}
inline void GradientPara::set_fstart(float value) {
  
  fstart_ = value;
  // @@protoc_insertion_point(field_set:OutPutCommon.GradientPara.fStart)
}

// float fEnd = 6;
inline void GradientPara::clear_fend() {
  fend_ = 0;
}
inline float GradientPara::fend() const {
  // @@protoc_insertion_point(field_get:OutPutCommon.GradientPara.fEnd)
  return fend_;
}
inline void GradientPara::set_fend(float value) {
  
  fend_ = value;
  // @@protoc_insertion_point(field_set:OutPutCommon.GradientPara.fEnd)
}

// uint32 nHarm = 7;
inline void GradientPara::clear_nharm() {
  nharm_ = 0u;
}
inline ::google::protobuf::uint32 GradientPara::nharm() const {
  // @@protoc_insertion_point(field_get:OutPutCommon.GradientPara.nHarm)
  return nharm_;
}
inline void GradientPara::set_nharm(::google::protobuf::uint32 value) {
  
  nharm_ = value;
  // @@protoc_insertion_point(field_set:OutPutCommon.GradientPara.nHarm)
}

// -------------------------------------------------------------------

// chanelpara

// float famptitude = 1;
inline void chanelpara::clear_famptitude() {
  famptitude_ = 0;
}
inline float chanelpara::famptitude() const {
  // @@protoc_insertion_point(field_get:OutPutCommon.chanelpara.famptitude)
  return famptitude_;
}
inline void chanelpara::set_famptitude(float value) {
  
  famptitude_ = value;
  // @@protoc_insertion_point(field_set:OutPutCommon.chanelpara.famptitude)
}

// float fphase = 2;
inline void chanelpara::clear_fphase() {
  fphase_ = 0;
}
inline float chanelpara::fphase() const {
  // @@protoc_insertion_point(field_get:OutPutCommon.chanelpara.fphase)
  return fphase_;
}
inline void chanelpara::set_fphase(float value) {
  
  fphase_ = value;
  // @@protoc_insertion_point(field_set:OutPutCommon.chanelpara.fphase)
}

// float ffre = 3;
inline void chanelpara::clear_ffre() {
  ffre_ = 0;
}
inline float chanelpara::ffre() const {
  // @@protoc_insertion_point(field_get:OutPutCommon.chanelpara.ffre)
  return ffre_;
}
inline void chanelpara::set_ffre(float value) {
  
  ffre_ = value;
  // @@protoc_insertion_point(field_set:OutPutCommon.chanelpara.ffre)
}

// -------------------------------------------------------------------

// acanalogpara

// repeated .OutPutCommon.chanelpara analogcurrentchanelvalue = 1;
inline int acanalogpara::analogcurrentchanelvalue_size() const {
  return analogcurrentchanelvalue_.size();
}
inline void acanalogpara::clear_analogcurrentchanelvalue() {
  analogcurrentchanelvalue_.Clear();
}
inline const ::OutPutCommon::chanelpara& acanalogpara::analogcurrentchanelvalue(int index) const {
  // @@protoc_insertion_point(field_get:OutPutCommon.acanalogpara.analogcurrentchanelvalue)
  return analogcurrentchanelvalue_.Get(index);
}
inline ::OutPutCommon::chanelpara* acanalogpara::mutable_analogcurrentchanelvalue(int index) {
  // @@protoc_insertion_point(field_mutable:OutPutCommon.acanalogpara.analogcurrentchanelvalue)
  return analogcurrentchanelvalue_.Mutable(index);
}
inline ::OutPutCommon::chanelpara* acanalogpara::add_analogcurrentchanelvalue() {
  // @@protoc_insertion_point(field_add:OutPutCommon.acanalogpara.analogcurrentchanelvalue)
  return analogcurrentchanelvalue_.Add();
}
inline ::google::protobuf::RepeatedPtrField< ::OutPutCommon::chanelpara >*
acanalogpara::mutable_analogcurrentchanelvalue() {
  // @@protoc_insertion_point(field_mutable_list:OutPutCommon.acanalogpara.analogcurrentchanelvalue)
  return &analogcurrentchanelvalue_;
}
inline const ::google::protobuf::RepeatedPtrField< ::OutPutCommon::chanelpara >&
acanalogpara::analogcurrentchanelvalue() const {
  // @@protoc_insertion_point(field_list:OutPutCommon.acanalogpara.analogcurrentchanelvalue)
  return analogcurrentchanelvalue_;
}

// repeated .OutPutCommon.chanelpara analogvoltchangelvalue = 2;
inline int acanalogpara::analogvoltchangelvalue_size() const {
  return analogvoltchangelvalue_.size();
}
inline void acanalogpara::clear_analogvoltchangelvalue() {
  analogvoltchangelvalue_.Clear();
}
inline const ::OutPutCommon::chanelpara& acanalogpara::analogvoltchangelvalue(int index) const {
  // @@protoc_insertion_point(field_get:OutPutCommon.acanalogpara.analogvoltchangelvalue)
  return analogvoltchangelvalue_.Get(index);
}
inline ::OutPutCommon::chanelpara* acanalogpara::mutable_analogvoltchangelvalue(int index) {
  // @@protoc_insertion_point(field_mutable:OutPutCommon.acanalogpara.analogvoltchangelvalue)
  return analogvoltchangelvalue_.Mutable(index);
}
inline ::OutPutCommon::chanelpara* acanalogpara::add_analogvoltchangelvalue() {
  // @@protoc_insertion_point(field_add:OutPutCommon.acanalogpara.analogvoltchangelvalue)
  return analogvoltchangelvalue_.Add();
}
inline ::google::protobuf::RepeatedPtrField< ::OutPutCommon::chanelpara >*
acanalogpara::mutable_analogvoltchangelvalue() {
  // @@protoc_insertion_point(field_mutable_list:OutPutCommon.acanalogpara.analogvoltchangelvalue)
  return &analogvoltchangelvalue_;
}
inline const ::google::protobuf::RepeatedPtrField< ::OutPutCommon::chanelpara >&
acanalogpara::analogvoltchangelvalue() const {
  // @@protoc_insertion_point(field_list:OutPutCommon.acanalogpara.analogvoltchangelvalue)
  return analogvoltchangelvalue_;
}

#endif  // !PROTOBUF_INLINE_NOT_IN_HEADERS
// -------------------------------------------------------------------

// -------------------------------------------------------------------


// @@protoc_insertion_point(namespace_scope)


}  // namespace OutPutCommon

#ifndef SWIG
namespace google {
namespace protobuf {

template <> struct is_proto_enum< ::OutPutCommon::para_type> : ::google::protobuf::internal::true_type {};
template <>
inline const EnumDescriptor* GetEnumDescriptor< ::OutPutCommon::para_type>() {
  return ::OutPutCommon::para_type_descriptor();
}
template <> struct is_proto_enum< ::OutPutCommon::changed_type> : ::google::protobuf::internal::true_type {};
template <>
inline const EnumDescriptor* GetEnumDescriptor< ::OutPutCommon::changed_type>() {
  return ::OutPutCommon::changed_type_descriptor();
}

}  // namespace protobuf
}  // namespace google
#endif  // SWIG

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_OutPutCommon_2eproto__INCLUDED