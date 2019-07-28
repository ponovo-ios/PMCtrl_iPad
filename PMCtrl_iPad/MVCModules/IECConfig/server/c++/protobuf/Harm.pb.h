// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: Harm.proto

#ifndef PROTOBUF_Harm_2eproto__INCLUDED
#define PROTOBUF_Harm_2eproto__INCLUDED

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
#include <google/protobuf/unknown_field_set.h>
#include "OutPutCommon.pb.h"
// @@protoc_insertion_point(includes)
namespace Harm {
class DCPara;
class DCParaDefaultTypeInternal;
extern DCParaDefaultTypeInternal _DCPara_default_instance_;
class HarmAnalog;
class HarmAnalogDefaultTypeInternal;
extern HarmAnalogDefaultTypeInternal _HarmAnalog_default_instance_;
}  // namespace Harm
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

namespace Harm {

namespace protobuf_Harm_2eproto {
// Internal implementation detail -- do not call these.
struct TableStruct {
  static const ::google::protobuf::uint32 offsets[];
  static void InitDefaultsImpl();
  static void Shutdown();
};
void AddDescriptors();
void InitDefaults();
}  // namespace protobuf_Harm_2eproto

// ===================================================================

class HarmAnalog : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:Harm.HarmAnalog) */ {
 public:
  HarmAnalog();
  virtual ~HarmAnalog();

  HarmAnalog(const HarmAnalog& from);

  inline HarmAnalog& operator=(const HarmAnalog& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const HarmAnalog& default_instance();

  static inline const HarmAnalog* internal_default_instance() {
    return reinterpret_cast<const HarmAnalog*>(
               &_HarmAnalog_default_instance_);
  }

  void Swap(HarmAnalog* other);

  // implements Message ----------------------------------------------

  inline HarmAnalog* New() const PROTOBUF_FINAL { return New(NULL); }

  HarmAnalog* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const HarmAnalog& from);
  void MergeFrom(const HarmAnalog& from);
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
  void InternalSwap(HarmAnalog* other);
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

  // repeated .OutPutCommon.acanalogpara oacanlogpara = 1;
  int oacanlogpara_size() const;
  void clear_oacanlogpara();
  static const int kOacanlogparaFieldNumber = 1;
  const ::OutPutCommon::acanalogpara& oacanlogpara(int index) const;
  ::OutPutCommon::acanalogpara* mutable_oacanlogpara(int index);
  ::OutPutCommon::acanalogpara* add_oacanlogpara();
  ::google::protobuf::RepeatedPtrField< ::OutPutCommon::acanalogpara >*
      mutable_oacanlogpara();
  const ::google::protobuf::RepeatedPtrField< ::OutPutCommon::acanalogpara >&
      oacanlogpara() const;

  // repeated .OutPutCommon.acanalogpara oacdigitalpara = 2;
  int oacdigitalpara_size() const;
  void clear_oacdigitalpara();
  static const int kOacdigitalparaFieldNumber = 2;
  const ::OutPutCommon::acanalogpara& oacdigitalpara(int index) const;
  ::OutPutCommon::acanalogpara* mutable_oacdigitalpara(int index);
  ::OutPutCommon::acanalogpara* add_oacdigitalpara();
  ::google::protobuf::RepeatedPtrField< ::OutPutCommon::acanalogpara >*
      mutable_oacdigitalpara();
  const ::google::protobuf::RepeatedPtrField< ::OutPutCommon::acanalogpara >&
      oacdigitalpara() const;

  // .OutPutCommon.GradientPara oGradientPara = 3;
  bool has_ogradientpara() const;
  void clear_ogradientpara();
  static const int kOGradientParaFieldNumber = 3;
  const ::OutPutCommon::GradientPara& ogradientpara() const;
  ::OutPutCommon::GradientPara* mutable_ogradientpara();
  ::OutPutCommon::GradientPara* release_ogradientpara();
  void set_allocated_ogradientpara(::OutPutCommon::GradientPara* ogradientpara);

  // .OutPutCommon.GradientPara oDigitalGradientPara = 4;
  bool has_odigitalgradientpara() const;
  void clear_odigitalgradientpara();
  static const int kODigitalGradientParaFieldNumber = 4;
  const ::OutPutCommon::GradientPara& odigitalgradientpara() const;
  ::OutPutCommon::GradientPara* mutable_odigitalgradientpara();
  ::OutPutCommon::GradientPara* release_odigitalgradientpara();
  void set_allocated_odigitalgradientpara(::OutPutCommon::GradientPara* odigitalgradientpara);

  // .Harm.DCPara oAnalogDC = 6;
  bool has_oanalogdc() const;
  void clear_oanalogdc();
  static const int kOAnalogDCFieldNumber = 6;
  const ::Harm::DCPara& oanalogdc() const;
  ::Harm::DCPara* mutable_oanalogdc();
  ::Harm::DCPara* release_oanalogdc();
  void set_allocated_oanalogdc(::Harm::DCPara* oanalogdc);

  // .Harm.DCPara oDigitalDC = 7;
  bool has_odigitaldc() const;
  void clear_odigitaldc();
  static const int kODigitalDCFieldNumber = 7;
  const ::Harm::DCPara& odigitaldc() const;
  ::Harm::DCPara* mutable_odigitaldc();
  ::Harm::DCPara* release_odigitaldc();
  void set_allocated_odigitaldc(::Harm::DCPara* odigitaldc);

  // uint32 iOutPut = 5;
  void clear_ioutput();
  static const int kIOutPutFieldNumber = 5;
  ::google::protobuf::uint32 ioutput() const;
  void set_ioutput(::google::protobuf::uint32 value);

  // bool bisAuto = 8;
  void clear_bisauto();
  static const int kBisAutoFieldNumber = 8;
  bool bisauto() const;
  void set_bisauto(bool value);

  // uint32 iInPut = 9;
  void clear_iinput();
  static const int kIInPutFieldNumber = 9;
  ::google::protobuf::uint32 iinput() const;
  void set_iinput(::google::protobuf::uint32 value);

  // uint32 iLogic = 10;
  void clear_ilogic();
  static const int kILogicFieldNumber = 10;
  ::google::protobuf::uint32 ilogic() const;
  void set_ilogic(::google::protobuf::uint32 value);

  // @@protoc_insertion_point(class_scope:Harm.HarmAnalog)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::RepeatedPtrField< ::OutPutCommon::acanalogpara > oacanlogpara_;
  ::google::protobuf::RepeatedPtrField< ::OutPutCommon::acanalogpara > oacdigitalpara_;
  ::OutPutCommon::GradientPara* ogradientpara_;
  ::OutPutCommon::GradientPara* odigitalgradientpara_;
  ::Harm::DCPara* oanalogdc_;
  ::Harm::DCPara* odigitaldc_;
  ::google::protobuf::uint32 ioutput_;
  bool bisauto_;
  ::google::protobuf::uint32 iinput_;
  ::google::protobuf::uint32 ilogic_;
  mutable int _cached_size_;
  friend struct  protobuf_Harm_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class DCPara : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:Harm.DCPara) */ {
 public:
  DCPara();
  virtual ~DCPara();

  DCPara(const DCPara& from);

  inline DCPara& operator=(const DCPara& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const DCPara& default_instance();

  static inline const DCPara* internal_default_instance() {
    return reinterpret_cast<const DCPara*>(
               &_DCPara_default_instance_);
  }

  void Swap(DCPara* other);

  // implements Message ----------------------------------------------

  inline DCPara* New() const PROTOBUF_FINAL { return New(NULL); }

  DCPara* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const DCPara& from);
  void MergeFrom(const DCPara& from);
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
  void InternalSwap(DCPara* other);
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

  // repeated uint32 analogvolt = 1;
  int analogvolt_size() const;
  void clear_analogvolt();
  static const int kAnalogvoltFieldNumber = 1;
  ::google::protobuf::uint32 analogvolt(int index) const;
  void set_analogvolt(int index, ::google::protobuf::uint32 value);
  void add_analogvolt(::google::protobuf::uint32 value);
  const ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >&
      analogvolt() const;
  ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >*
      mutable_analogvolt();

  // repeated uint32 analogCurrent = 2;
  int analogcurrent_size() const;
  void clear_analogcurrent();
  static const int kAnalogCurrentFieldNumber = 2;
  ::google::protobuf::uint32 analogcurrent(int index) const;
  void set_analogcurrent(int index, ::google::protobuf::uint32 value);
  void add_analogcurrent(::google::protobuf::uint32 value);
  const ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >&
      analogcurrent() const;
  ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >*
      mutable_analogcurrent();

  // @@protoc_insertion_point(class_scope:Harm.DCPara)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::RepeatedField< ::google::protobuf::uint32 > analogvolt_;
  mutable int _analogvolt_cached_byte_size_;
  ::google::protobuf::RepeatedField< ::google::protobuf::uint32 > analogcurrent_;
  mutable int _analogcurrent_cached_byte_size_;
  mutable int _cached_size_;
  friend struct  protobuf_Harm_2eproto::TableStruct;
};
// ===================================================================


// ===================================================================

#if !PROTOBUF_INLINE_NOT_IN_HEADERS
// HarmAnalog

// repeated .OutPutCommon.acanalogpara oacanlogpara = 1;
inline int HarmAnalog::oacanlogpara_size() const {
  return oacanlogpara_.size();
}
inline void HarmAnalog::clear_oacanlogpara() {
  oacanlogpara_.Clear();
}
inline const ::OutPutCommon::acanalogpara& HarmAnalog::oacanlogpara(int index) const {
  // @@protoc_insertion_point(field_get:Harm.HarmAnalog.oacanlogpara)
  return oacanlogpara_.Get(index);
}
inline ::OutPutCommon::acanalogpara* HarmAnalog::mutable_oacanlogpara(int index) {
  // @@protoc_insertion_point(field_mutable:Harm.HarmAnalog.oacanlogpara)
  return oacanlogpara_.Mutable(index);
}
inline ::OutPutCommon::acanalogpara* HarmAnalog::add_oacanlogpara() {
  // @@protoc_insertion_point(field_add:Harm.HarmAnalog.oacanlogpara)
  return oacanlogpara_.Add();
}
inline ::google::protobuf::RepeatedPtrField< ::OutPutCommon::acanalogpara >*
HarmAnalog::mutable_oacanlogpara() {
  // @@protoc_insertion_point(field_mutable_list:Harm.HarmAnalog.oacanlogpara)
  return &oacanlogpara_;
}
inline const ::google::protobuf::RepeatedPtrField< ::OutPutCommon::acanalogpara >&
HarmAnalog::oacanlogpara() const {
  // @@protoc_insertion_point(field_list:Harm.HarmAnalog.oacanlogpara)
  return oacanlogpara_;
}

// repeated .OutPutCommon.acanalogpara oacdigitalpara = 2;
inline int HarmAnalog::oacdigitalpara_size() const {
  return oacdigitalpara_.size();
}
inline void HarmAnalog::clear_oacdigitalpara() {
  oacdigitalpara_.Clear();
}
inline const ::OutPutCommon::acanalogpara& HarmAnalog::oacdigitalpara(int index) const {
  // @@protoc_insertion_point(field_get:Harm.HarmAnalog.oacdigitalpara)
  return oacdigitalpara_.Get(index);
}
inline ::OutPutCommon::acanalogpara* HarmAnalog::mutable_oacdigitalpara(int index) {
  // @@protoc_insertion_point(field_mutable:Harm.HarmAnalog.oacdigitalpara)
  return oacdigitalpara_.Mutable(index);
}
inline ::OutPutCommon::acanalogpara* HarmAnalog::add_oacdigitalpara() {
  // @@protoc_insertion_point(field_add:Harm.HarmAnalog.oacdigitalpara)
  return oacdigitalpara_.Add();
}
inline ::google::protobuf::RepeatedPtrField< ::OutPutCommon::acanalogpara >*
HarmAnalog::mutable_oacdigitalpara() {
  // @@protoc_insertion_point(field_mutable_list:Harm.HarmAnalog.oacdigitalpara)
  return &oacdigitalpara_;
}
inline const ::google::protobuf::RepeatedPtrField< ::OutPutCommon::acanalogpara >&
HarmAnalog::oacdigitalpara() const {
  // @@protoc_insertion_point(field_list:Harm.HarmAnalog.oacdigitalpara)
  return oacdigitalpara_;
}

// .OutPutCommon.GradientPara oGradientPara = 3;
inline bool HarmAnalog::has_ogradientpara() const {
  return this != internal_default_instance() && ogradientpara_ != NULL;
}
inline void HarmAnalog::clear_ogradientpara() {
  if (GetArenaNoVirtual() == NULL && ogradientpara_ != NULL) delete ogradientpara_;
  ogradientpara_ = NULL;
}
inline const ::OutPutCommon::GradientPara& HarmAnalog::ogradientpara() const {
  // @@protoc_insertion_point(field_get:Harm.HarmAnalog.oGradientPara)
  return ogradientpara_ != NULL ? *ogradientpara_
                         : *::OutPutCommon::GradientPara::internal_default_instance();
}
inline ::OutPutCommon::GradientPara* HarmAnalog::mutable_ogradientpara() {
  
  if (ogradientpara_ == NULL) {
    ogradientpara_ = new ::OutPutCommon::GradientPara;
  }
  // @@protoc_insertion_point(field_mutable:Harm.HarmAnalog.oGradientPara)
  return ogradientpara_;
}
inline ::OutPutCommon::GradientPara* HarmAnalog::release_ogradientpara() {
  // @@protoc_insertion_point(field_release:Harm.HarmAnalog.oGradientPara)
  
  ::OutPutCommon::GradientPara* temp = ogradientpara_;
  ogradientpara_ = NULL;
  return temp;
}
inline void HarmAnalog::set_allocated_ogradientpara(::OutPutCommon::GradientPara* ogradientpara) {
  delete ogradientpara_;
  ogradientpara_ = ogradientpara;
  if (ogradientpara) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:Harm.HarmAnalog.oGradientPara)
}

// .OutPutCommon.GradientPara oDigitalGradientPara = 4;
inline bool HarmAnalog::has_odigitalgradientpara() const {
  return this != internal_default_instance() && odigitalgradientpara_ != NULL;
}
inline void HarmAnalog::clear_odigitalgradientpara() {
  if (GetArenaNoVirtual() == NULL && odigitalgradientpara_ != NULL) delete odigitalgradientpara_;
  odigitalgradientpara_ = NULL;
}
inline const ::OutPutCommon::GradientPara& HarmAnalog::odigitalgradientpara() const {
  // @@protoc_insertion_point(field_get:Harm.HarmAnalog.oDigitalGradientPara)
  return odigitalgradientpara_ != NULL ? *odigitalgradientpara_
                         : *::OutPutCommon::GradientPara::internal_default_instance();
}
inline ::OutPutCommon::GradientPara* HarmAnalog::mutable_odigitalgradientpara() {
  
  if (odigitalgradientpara_ == NULL) {
    odigitalgradientpara_ = new ::OutPutCommon::GradientPara;
  }
  // @@protoc_insertion_point(field_mutable:Harm.HarmAnalog.oDigitalGradientPara)
  return odigitalgradientpara_;
}
inline ::OutPutCommon::GradientPara* HarmAnalog::release_odigitalgradientpara() {
  // @@protoc_insertion_point(field_release:Harm.HarmAnalog.oDigitalGradientPara)
  
  ::OutPutCommon::GradientPara* temp = odigitalgradientpara_;
  odigitalgradientpara_ = NULL;
  return temp;
}
inline void HarmAnalog::set_allocated_odigitalgradientpara(::OutPutCommon::GradientPara* odigitalgradientpara) {
  delete odigitalgradientpara_;
  odigitalgradientpara_ = odigitalgradientpara;
  if (odigitalgradientpara) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:Harm.HarmAnalog.oDigitalGradientPara)
}

// uint32 iOutPut = 5;
inline void HarmAnalog::clear_ioutput() {
  ioutput_ = 0u;
}
inline ::google::protobuf::uint32 HarmAnalog::ioutput() const {
  // @@protoc_insertion_point(field_get:Harm.HarmAnalog.iOutPut)
  return ioutput_;
}
inline void HarmAnalog::set_ioutput(::google::protobuf::uint32 value) {
  
  ioutput_ = value;
  // @@protoc_insertion_point(field_set:Harm.HarmAnalog.iOutPut)
}

// .Harm.DCPara oAnalogDC = 6;
inline bool HarmAnalog::has_oanalogdc() const {
  return this != internal_default_instance() && oanalogdc_ != NULL;
}
inline void HarmAnalog::clear_oanalogdc() {
  if (GetArenaNoVirtual() == NULL && oanalogdc_ != NULL) delete oanalogdc_;
  oanalogdc_ = NULL;
}
inline const ::Harm::DCPara& HarmAnalog::oanalogdc() const {
  // @@protoc_insertion_point(field_get:Harm.HarmAnalog.oAnalogDC)
  return oanalogdc_ != NULL ? *oanalogdc_
                         : *::Harm::DCPara::internal_default_instance();
}
inline ::Harm::DCPara* HarmAnalog::mutable_oanalogdc() {
  
  if (oanalogdc_ == NULL) {
    oanalogdc_ = new ::Harm::DCPara;
  }
  // @@protoc_insertion_point(field_mutable:Harm.HarmAnalog.oAnalogDC)
  return oanalogdc_;
}
inline ::Harm::DCPara* HarmAnalog::release_oanalogdc() {
  // @@protoc_insertion_point(field_release:Harm.HarmAnalog.oAnalogDC)
  
  ::Harm::DCPara* temp = oanalogdc_;
  oanalogdc_ = NULL;
  return temp;
}
inline void HarmAnalog::set_allocated_oanalogdc(::Harm::DCPara* oanalogdc) {
  delete oanalogdc_;
  oanalogdc_ = oanalogdc;
  if (oanalogdc) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:Harm.HarmAnalog.oAnalogDC)
}

// .Harm.DCPara oDigitalDC = 7;
inline bool HarmAnalog::has_odigitaldc() const {
  return this != internal_default_instance() && odigitaldc_ != NULL;
}
inline void HarmAnalog::clear_odigitaldc() {
  if (GetArenaNoVirtual() == NULL && odigitaldc_ != NULL) delete odigitaldc_;
  odigitaldc_ = NULL;
}
inline const ::Harm::DCPara& HarmAnalog::odigitaldc() const {
  // @@protoc_insertion_point(field_get:Harm.HarmAnalog.oDigitalDC)
  return odigitaldc_ != NULL ? *odigitaldc_
                         : *::Harm::DCPara::internal_default_instance();
}
inline ::Harm::DCPara* HarmAnalog::mutable_odigitaldc() {
  
  if (odigitaldc_ == NULL) {
    odigitaldc_ = new ::Harm::DCPara;
  }
  // @@protoc_insertion_point(field_mutable:Harm.HarmAnalog.oDigitalDC)
  return odigitaldc_;
}
inline ::Harm::DCPara* HarmAnalog::release_odigitaldc() {
  // @@protoc_insertion_point(field_release:Harm.HarmAnalog.oDigitalDC)
  
  ::Harm::DCPara* temp = odigitaldc_;
  odigitaldc_ = NULL;
  return temp;
}
inline void HarmAnalog::set_allocated_odigitaldc(::Harm::DCPara* odigitaldc) {
  delete odigitaldc_;
  odigitaldc_ = odigitaldc;
  if (odigitaldc) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:Harm.HarmAnalog.oDigitalDC)
}

// bool bisAuto = 8;
inline void HarmAnalog::clear_bisauto() {
  bisauto_ = false;
}
inline bool HarmAnalog::bisauto() const {
  // @@protoc_insertion_point(field_get:Harm.HarmAnalog.bisAuto)
  return bisauto_;
}
inline void HarmAnalog::set_bisauto(bool value) {
  
  bisauto_ = value;
  // @@protoc_insertion_point(field_set:Harm.HarmAnalog.bisAuto)
}

// uint32 iInPut = 9;
inline void HarmAnalog::clear_iinput() {
  iinput_ = 0u;
}
inline ::google::protobuf::uint32 HarmAnalog::iinput() const {
  // @@protoc_insertion_point(field_get:Harm.HarmAnalog.iInPut)
  return iinput_;
}
inline void HarmAnalog::set_iinput(::google::protobuf::uint32 value) {
  
  iinput_ = value;
  // @@protoc_insertion_point(field_set:Harm.HarmAnalog.iInPut)
}

// uint32 iLogic = 10;
inline void HarmAnalog::clear_ilogic() {
  ilogic_ = 0u;
}
inline ::google::protobuf::uint32 HarmAnalog::ilogic() const {
  // @@protoc_insertion_point(field_get:Harm.HarmAnalog.iLogic)
  return ilogic_;
}
inline void HarmAnalog::set_ilogic(::google::protobuf::uint32 value) {
  
  ilogic_ = value;
  // @@protoc_insertion_point(field_set:Harm.HarmAnalog.iLogic)
}

// -------------------------------------------------------------------

// DCPara

// repeated uint32 analogvolt = 1;
inline int DCPara::analogvolt_size() const {
  return analogvolt_.size();
}
inline void DCPara::clear_analogvolt() {
  analogvolt_.Clear();
}
inline ::google::protobuf::uint32 DCPara::analogvolt(int index) const {
  // @@protoc_insertion_point(field_get:Harm.DCPara.analogvolt)
  return analogvolt_.Get(index);
}
inline void DCPara::set_analogvolt(int index, ::google::protobuf::uint32 value) {
  analogvolt_.Set(index, value);
  // @@protoc_insertion_point(field_set:Harm.DCPara.analogvolt)
}
inline void DCPara::add_analogvolt(::google::protobuf::uint32 value) {
  analogvolt_.Add(value);
  // @@protoc_insertion_point(field_add:Harm.DCPara.analogvolt)
}
inline const ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >&
DCPara::analogvolt() const {
  // @@protoc_insertion_point(field_list:Harm.DCPara.analogvolt)
  return analogvolt_;
}
inline ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >*
DCPara::mutable_analogvolt() {
  // @@protoc_insertion_point(field_mutable_list:Harm.DCPara.analogvolt)
  return &analogvolt_;
}

// repeated uint32 analogCurrent = 2;
inline int DCPara::analogcurrent_size() const {
  return analogcurrent_.size();
}
inline void DCPara::clear_analogcurrent() {
  analogcurrent_.Clear();
}
inline ::google::protobuf::uint32 DCPara::analogcurrent(int index) const {
  // @@protoc_insertion_point(field_get:Harm.DCPara.analogCurrent)
  return analogcurrent_.Get(index);
}
inline void DCPara::set_analogcurrent(int index, ::google::protobuf::uint32 value) {
  analogcurrent_.Set(index, value);
  // @@protoc_insertion_point(field_set:Harm.DCPara.analogCurrent)
}
inline void DCPara::add_analogcurrent(::google::protobuf::uint32 value) {
  analogcurrent_.Add(value);
  // @@protoc_insertion_point(field_add:Harm.DCPara.analogCurrent)
}
inline const ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >&
DCPara::analogcurrent() const {
  // @@protoc_insertion_point(field_list:Harm.DCPara.analogCurrent)
  return analogcurrent_;
}
inline ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >*
DCPara::mutable_analogcurrent() {
  // @@protoc_insertion_point(field_mutable_list:Harm.DCPara.analogCurrent)
  return &analogcurrent_;
}

#endif  // !PROTOBUF_INLINE_NOT_IN_HEADERS
// -------------------------------------------------------------------


// @@protoc_insertion_point(namespace_scope)


}  // namespace Harm

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_Harm_2eproto__INCLUDED