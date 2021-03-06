// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: manuTest.proto

#ifndef PROTOBUF_manuTest_2eproto__INCLUDED
#define PROTOBUF_manuTest_2eproto__INCLUDED

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
namespace ManuTestPara {
class CommonPara;
class CommonParaDefaultTypeInternal;
extern CommonParaDefaultTypeInternal _CommonPara_default_instance_;
class SwitchPara;
class SwitchParaDefaultTypeInternal;
extern SwitchParaDefaultTypeInternal _SwitchPara_default_instance_;
class TestItem;
class TestItemDefaultTypeInternal;
extern TestItemDefaultTypeInternal _TestItem_default_instance_;
class realPara;
class realParaDefaultTypeInternal;
extern realParaDefaultTypeInternal _realPara_default_instance_;
}  // namespace ManuTestPara
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
class result;
class resultDefaultTypeInternal;
extern resultDefaultTypeInternal _result_default_instance_;
class resultItem;
class resultItemDefaultTypeInternal;
extern resultItemDefaultTypeInternal _resultItem_default_instance_;
}  // namespace OutPutCommon

namespace ManuTestPara {

namespace protobuf_manuTest_2eproto {
// Internal implementation detail -- do not call these.
struct TableStruct {
  static const ::google::protobuf::uint32 offsets[];
  static void InitDefaultsImpl();
  static void Shutdown();
};
void AddDescriptors();
void InitDefaults();
}  // namespace protobuf_manuTest_2eproto

// ===================================================================

class SwitchPara : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:ManuTestPara.SwitchPara) */ {
 public:
  SwitchPara();
  virtual ~SwitchPara();

  SwitchPara(const SwitchPara& from);

  inline SwitchPara& operator=(const SwitchPara& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const SwitchPara& default_instance();

  static inline const SwitchPara* internal_default_instance() {
    return reinterpret_cast<const SwitchPara*>(
               &_SwitchPara_default_instance_);
  }

  void Swap(SwitchPara* other);

  // implements Message ----------------------------------------------

  inline SwitchPara* New() const PROTOBUF_FINAL { return New(NULL); }

  SwitchPara* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const SwitchPara& from);
  void MergeFrom(const SwitchPara& from);
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
  void InternalSwap(SwitchPara* other);
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

  // uint32 iInPut = 1;
  void clear_iinput();
  static const int kIInPutFieldNumber = 1;
  ::google::protobuf::uint32 iinput() const;
  void set_iinput(::google::protobuf::uint32 value);

  // uint32 iLogic = 2;
  void clear_ilogic();
  static const int kILogicFieldNumber = 2;
  ::google::protobuf::uint32 ilogic() const;
  void set_ilogic(::google::protobuf::uint32 value);

  // uint32 iOutPut = 3;
  void clear_ioutput();
  static const int kIOutPutFieldNumber = 3;
  ::google::protobuf::uint32 ioutput() const;
  void set_ioutput(::google::protobuf::uint32 value);

  // @@protoc_insertion_point(class_scope:ManuTestPara.SwitchPara)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::uint32 iinput_;
  ::google::protobuf::uint32 ilogic_;
  ::google::protobuf::uint32 ioutput_;
  mutable int _cached_size_;
  friend struct  protobuf_manuTest_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class CommonPara : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:ManuTestPara.CommonPara) */ {
 public:
  CommonPara();
  virtual ~CommonPara();

  CommonPara(const CommonPara& from);

  inline CommonPara& operator=(const CommonPara& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const CommonPara& default_instance();

  static inline const CommonPara* internal_default_instance() {
    return reinterpret_cast<const CommonPara*>(
               &_CommonPara_default_instance_);
  }

  void Swap(CommonPara* other);

  // implements Message ----------------------------------------------

  inline CommonPara* New() const PROTOBUF_FINAL { return New(NULL); }

  CommonPara* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const CommonPara& from);
  void MergeFrom(const CommonPara& from);
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
  void InternalSwap(CommonPara* other);
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

  // float fTrigDelay = 1;
  void clear_ftrigdelay();
  static const int kFTrigDelayFieldNumber = 1;
  float ftrigdelay() const;
  void set_ftrigdelay(float value);

  // bool bAgingTest = 2;
  void clear_bagingtest();
  static const int kBAgingTestFieldNumber = 2;
  bool bagingtest() const;
  void set_bagingtest(bool value);

  // bool bDcTest = 3;
  void clear_bdctest();
  static const int kBDcTestFieldNumber = 3;
  bool bdctest() const;
  void set_bdctest(bool value);

  // bool bAutoTest = 4;
  void clear_bautotest();
  static const int kBAutoTestFieldNumber = 4;
  bool bautotest() const;
  void set_bautotest(bool value);

  // bool bLock = 5;
  void clear_block();
  static const int kBLockFieldNumber = 5;
  bool block() const;
  void set_block(bool value);

  // uint32 iTestType = 6;
  void clear_itesttype();
  static const int kITestTypeFieldNumber = 6;
  ::google::protobuf::uint32 itesttype() const;
  void set_itesttype(::google::protobuf::uint32 value);

  // @@protoc_insertion_point(class_scope:ManuTestPara.CommonPara)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  float ftrigdelay_;
  bool bagingtest_;
  bool bdctest_;
  bool bautotest_;
  bool block_;
  ::google::protobuf::uint32 itesttype_;
  mutable int _cached_size_;
  friend struct  protobuf_manuTest_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class TestItem : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:ManuTestPara.TestItem) */ {
 public:
  TestItem();
  virtual ~TestItem();

  TestItem(const TestItem& from);

  inline TestItem& operator=(const TestItem& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const TestItem& default_instance();

  static inline const TestItem* internal_default_instance() {
    return reinterpret_cast<const TestItem*>(
               &_TestItem_default_instance_);
  }

  void Swap(TestItem* other);

  // implements Message ----------------------------------------------

  inline TestItem* New() const PROTOBUF_FINAL { return New(NULL); }

  TestItem* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const TestItem& from);
  void MergeFrom(const TestItem& from);
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
  void InternalSwap(TestItem* other);
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

  // .ManuTestPara.CommonPara oCommonPara = 1;
  bool has_ocommonpara() const;
  void clear_ocommonpara();
  static const int kOCommonParaFieldNumber = 1;
  const ::ManuTestPara::CommonPara& ocommonpara() const;
  ::ManuTestPara::CommonPara* mutable_ocommonpara();
  ::ManuTestPara::CommonPara* release_ocommonpara();
  void set_allocated_ocommonpara(::ManuTestPara::CommonPara* ocommonpara);

  // .OutPutCommon.acanalogpara oacanlogpara = 2;
  bool has_oacanlogpara() const;
  void clear_oacanlogpara();
  static const int kOacanlogparaFieldNumber = 2;
  const ::OutPutCommon::acanalogpara& oacanlogpara() const;
  ::OutPutCommon::acanalogpara* mutable_oacanlogpara();
  ::OutPutCommon::acanalogpara* release_oacanlogpara();
  void set_allocated_oacanlogpara(::OutPutCommon::acanalogpara* oacanlogpara);

  // .OutPutCommon.acanalogpara oacdigitalpara = 3;
  bool has_oacdigitalpara() const;
  void clear_oacdigitalpara();
  static const int kOacdigitalparaFieldNumber = 3;
  const ::OutPutCommon::acanalogpara& oacdigitalpara() const;
  ::OutPutCommon::acanalogpara* mutable_oacdigitalpara();
  ::OutPutCommon::acanalogpara* release_oacdigitalpara();
  void set_allocated_oacdigitalpara(::OutPutCommon::acanalogpara* oacdigitalpara);

  // .OutPutCommon.GradientPara oanaGradientpara = 4;
  bool has_oanagradientpara() const;
  void clear_oanagradientpara();
  static const int kOanaGradientparaFieldNumber = 4;
  const ::OutPutCommon::GradientPara& oanagradientpara() const;
  ::OutPutCommon::GradientPara* mutable_oanagradientpara();
  ::OutPutCommon::GradientPara* release_oanagradientpara();
  void set_allocated_oanagradientpara(::OutPutCommon::GradientPara* oanagradientpara);

  // .OutPutCommon.GradientPara odigGradientpara = 5;
  bool has_odiggradientpara() const;
  void clear_odiggradientpara();
  static const int kOdigGradientparaFieldNumber = 5;
  const ::OutPutCommon::GradientPara& odiggradientpara() const;
  ::OutPutCommon::GradientPara* mutable_odiggradientpara();
  ::OutPutCommon::GradientPara* release_odiggradientpara();
  void set_allocated_odiggradientpara(::OutPutCommon::GradientPara* odiggradientpara);

  // .ManuTestPara.SwitchPara oswitchpara = 6;
  bool has_oswitchpara() const;
  void clear_oswitchpara();
  static const int kOswitchparaFieldNumber = 6;
  const ::ManuTestPara::SwitchPara& oswitchpara() const;
  ::ManuTestPara::SwitchPara* mutable_oswitchpara();
  ::ManuTestPara::SwitchPara* release_oswitchpara();
  void set_allocated_oswitchpara(::ManuTestPara::SwitchPara* oswitchpara);

  // @@protoc_insertion_point(class_scope:ManuTestPara.TestItem)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::ManuTestPara::CommonPara* ocommonpara_;
  ::OutPutCommon::acanalogpara* oacanlogpara_;
  ::OutPutCommon::acanalogpara* oacdigitalpara_;
  ::OutPutCommon::GradientPara* oanagradientpara_;
  ::OutPutCommon::GradientPara* odiggradientpara_;
  ::ManuTestPara::SwitchPara* oswitchpara_;
  mutable int _cached_size_;
  friend struct  protobuf_manuTest_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class realPara : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:ManuTestPara.realPara) */ {
 public:
  realPara();
  virtual ~realPara();

  realPara(const realPara& from);

  inline realPara& operator=(const realPara& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const realPara& default_instance();

  static inline const realPara* internal_default_instance() {
    return reinterpret_cast<const realPara*>(
               &_realPara_default_instance_);
  }

  void Swap(realPara* other);

  // implements Message ----------------------------------------------

  inline realPara* New() const PROTOBUF_FINAL { return New(NULL); }

  realPara* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const realPara& from);
  void MergeFrom(const realPara& from);
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
  void InternalSwap(realPara* other);
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

  // .OutPutCommon.acanalogpara oacanlogpara = 1;
  bool has_oacanlogpara() const;
  void clear_oacanlogpara();
  static const int kOacanlogparaFieldNumber = 1;
  const ::OutPutCommon::acanalogpara& oacanlogpara() const;
  ::OutPutCommon::acanalogpara* mutable_oacanlogpara();
  ::OutPutCommon::acanalogpara* release_oacanlogpara();
  void set_allocated_oacanlogpara(::OutPutCommon::acanalogpara* oacanlogpara);

  // .OutPutCommon.acanalogpara oacdigitalpara = 2;
  bool has_oacdigitalpara() const;
  void clear_oacdigitalpara();
  static const int kOacdigitalparaFieldNumber = 2;
  const ::OutPutCommon::acanalogpara& oacdigitalpara() const;
  ::OutPutCommon::acanalogpara* mutable_oacdigitalpara();
  ::OutPutCommon::acanalogpara* release_oacdigitalpara();
  void set_allocated_oacdigitalpara(::OutPutCommon::acanalogpara* oacdigitalpara);

  // @@protoc_insertion_point(class_scope:ManuTestPara.realPara)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::OutPutCommon::acanalogpara* oacanlogpara_;
  ::OutPutCommon::acanalogpara* oacdigitalpara_;
  mutable int _cached_size_;
  friend struct  protobuf_manuTest_2eproto::TableStruct;
};
// ===================================================================


// ===================================================================

#if !PROTOBUF_INLINE_NOT_IN_HEADERS
// SwitchPara

// uint32 iInPut = 1;
inline void SwitchPara::clear_iinput() {
  iinput_ = 0u;
}
inline ::google::protobuf::uint32 SwitchPara::iinput() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.SwitchPara.iInPut)
  return iinput_;
}
inline void SwitchPara::set_iinput(::google::protobuf::uint32 value) {
  
  iinput_ = value;
  // @@protoc_insertion_point(field_set:ManuTestPara.SwitchPara.iInPut)
}

// uint32 iLogic = 2;
inline void SwitchPara::clear_ilogic() {
  ilogic_ = 0u;
}
inline ::google::protobuf::uint32 SwitchPara::ilogic() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.SwitchPara.iLogic)
  return ilogic_;
}
inline void SwitchPara::set_ilogic(::google::protobuf::uint32 value) {
  
  ilogic_ = value;
  // @@protoc_insertion_point(field_set:ManuTestPara.SwitchPara.iLogic)
}

// uint32 iOutPut = 3;
inline void SwitchPara::clear_ioutput() {
  ioutput_ = 0u;
}
inline ::google::protobuf::uint32 SwitchPara::ioutput() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.SwitchPara.iOutPut)
  return ioutput_;
}
inline void SwitchPara::set_ioutput(::google::protobuf::uint32 value) {
  
  ioutput_ = value;
  // @@protoc_insertion_point(field_set:ManuTestPara.SwitchPara.iOutPut)
}

// -------------------------------------------------------------------

// CommonPara

// float fTrigDelay = 1;
inline void CommonPara::clear_ftrigdelay() {
  ftrigdelay_ = 0;
}
inline float CommonPara::ftrigdelay() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.CommonPara.fTrigDelay)
  return ftrigdelay_;
}
inline void CommonPara::set_ftrigdelay(float value) {
  
  ftrigdelay_ = value;
  // @@protoc_insertion_point(field_set:ManuTestPara.CommonPara.fTrigDelay)
}

// bool bAgingTest = 2;
inline void CommonPara::clear_bagingtest() {
  bagingtest_ = false;
}
inline bool CommonPara::bagingtest() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.CommonPara.bAgingTest)
  return bagingtest_;
}
inline void CommonPara::set_bagingtest(bool value) {
  
  bagingtest_ = value;
  // @@protoc_insertion_point(field_set:ManuTestPara.CommonPara.bAgingTest)
}

// bool bDcTest = 3;
inline void CommonPara::clear_bdctest() {
  bdctest_ = false;
}
inline bool CommonPara::bdctest() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.CommonPara.bDcTest)
  return bdctest_;
}
inline void CommonPara::set_bdctest(bool value) {
  
  bdctest_ = value;
  // @@protoc_insertion_point(field_set:ManuTestPara.CommonPara.bDcTest)
}

// bool bAutoTest = 4;
inline void CommonPara::clear_bautotest() {
  bautotest_ = false;
}
inline bool CommonPara::bautotest() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.CommonPara.bAutoTest)
  return bautotest_;
}
inline void CommonPara::set_bautotest(bool value) {
  
  bautotest_ = value;
  // @@protoc_insertion_point(field_set:ManuTestPara.CommonPara.bAutoTest)
}

// bool bLock = 5;
inline void CommonPara::clear_block() {
  block_ = false;
}
inline bool CommonPara::block() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.CommonPara.bLock)
  return block_;
}
inline void CommonPara::set_block(bool value) {
  
  block_ = value;
  // @@protoc_insertion_point(field_set:ManuTestPara.CommonPara.bLock)
}

// uint32 iTestType = 6;
inline void CommonPara::clear_itesttype() {
  itesttype_ = 0u;
}
inline ::google::protobuf::uint32 CommonPara::itesttype() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.CommonPara.iTestType)
  return itesttype_;
}
inline void CommonPara::set_itesttype(::google::protobuf::uint32 value) {
  
  itesttype_ = value;
  // @@protoc_insertion_point(field_set:ManuTestPara.CommonPara.iTestType)
}

// -------------------------------------------------------------------

// TestItem

// .ManuTestPara.CommonPara oCommonPara = 1;
inline bool TestItem::has_ocommonpara() const {
  return this != internal_default_instance() && ocommonpara_ != NULL;
}
inline void TestItem::clear_ocommonpara() {
  if (GetArenaNoVirtual() == NULL && ocommonpara_ != NULL) delete ocommonpara_;
  ocommonpara_ = NULL;
}
inline const ::ManuTestPara::CommonPara& TestItem::ocommonpara() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.TestItem.oCommonPara)
  return ocommonpara_ != NULL ? *ocommonpara_
                         : *::ManuTestPara::CommonPara::internal_default_instance();
}
inline ::ManuTestPara::CommonPara* TestItem::mutable_ocommonpara() {
  
  if (ocommonpara_ == NULL) {
    ocommonpara_ = new ::ManuTestPara::CommonPara;
  }
  // @@protoc_insertion_point(field_mutable:ManuTestPara.TestItem.oCommonPara)
  return ocommonpara_;
}
inline ::ManuTestPara::CommonPara* TestItem::release_ocommonpara() {
  // @@protoc_insertion_point(field_release:ManuTestPara.TestItem.oCommonPara)
  
  ::ManuTestPara::CommonPara* temp = ocommonpara_;
  ocommonpara_ = NULL;
  return temp;
}
inline void TestItem::set_allocated_ocommonpara(::ManuTestPara::CommonPara* ocommonpara) {
  delete ocommonpara_;
  ocommonpara_ = ocommonpara;
  if (ocommonpara) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:ManuTestPara.TestItem.oCommonPara)
}

// .OutPutCommon.acanalogpara oacanlogpara = 2;
inline bool TestItem::has_oacanlogpara() const {
  return this != internal_default_instance() && oacanlogpara_ != NULL;
}
inline void TestItem::clear_oacanlogpara() {
  if (GetArenaNoVirtual() == NULL && oacanlogpara_ != NULL) delete oacanlogpara_;
  oacanlogpara_ = NULL;
}
inline const ::OutPutCommon::acanalogpara& TestItem::oacanlogpara() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.TestItem.oacanlogpara)
  return oacanlogpara_ != NULL ? *oacanlogpara_
                         : *::OutPutCommon::acanalogpara::internal_default_instance();
}
inline ::OutPutCommon::acanalogpara* TestItem::mutable_oacanlogpara() {
  
  if (oacanlogpara_ == NULL) {
    oacanlogpara_ = new ::OutPutCommon::acanalogpara;
  }
  // @@protoc_insertion_point(field_mutable:ManuTestPara.TestItem.oacanlogpara)
  return oacanlogpara_;
}
inline ::OutPutCommon::acanalogpara* TestItem::release_oacanlogpara() {
  // @@protoc_insertion_point(field_release:ManuTestPara.TestItem.oacanlogpara)
  
  ::OutPutCommon::acanalogpara* temp = oacanlogpara_;
  oacanlogpara_ = NULL;
  return temp;
}
inline void TestItem::set_allocated_oacanlogpara(::OutPutCommon::acanalogpara* oacanlogpara) {
  delete oacanlogpara_;
  oacanlogpara_ = oacanlogpara;
  if (oacanlogpara) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:ManuTestPara.TestItem.oacanlogpara)
}

// .OutPutCommon.acanalogpara oacdigitalpara = 3;
inline bool TestItem::has_oacdigitalpara() const {
  return this != internal_default_instance() && oacdigitalpara_ != NULL;
}
inline void TestItem::clear_oacdigitalpara() {
  if (GetArenaNoVirtual() == NULL && oacdigitalpara_ != NULL) delete oacdigitalpara_;
  oacdigitalpara_ = NULL;
}
inline const ::OutPutCommon::acanalogpara& TestItem::oacdigitalpara() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.TestItem.oacdigitalpara)
  return oacdigitalpara_ != NULL ? *oacdigitalpara_
                         : *::OutPutCommon::acanalogpara::internal_default_instance();
}
inline ::OutPutCommon::acanalogpara* TestItem::mutable_oacdigitalpara() {
  
  if (oacdigitalpara_ == NULL) {
    oacdigitalpara_ = new ::OutPutCommon::acanalogpara;
  }
  // @@protoc_insertion_point(field_mutable:ManuTestPara.TestItem.oacdigitalpara)
  return oacdigitalpara_;
}
inline ::OutPutCommon::acanalogpara* TestItem::release_oacdigitalpara() {
  // @@protoc_insertion_point(field_release:ManuTestPara.TestItem.oacdigitalpara)
  
  ::OutPutCommon::acanalogpara* temp = oacdigitalpara_;
  oacdigitalpara_ = NULL;
  return temp;
}
inline void TestItem::set_allocated_oacdigitalpara(::OutPutCommon::acanalogpara* oacdigitalpara) {
  delete oacdigitalpara_;
  oacdigitalpara_ = oacdigitalpara;
  if (oacdigitalpara) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:ManuTestPara.TestItem.oacdigitalpara)
}

// .OutPutCommon.GradientPara oanaGradientpara = 4;
inline bool TestItem::has_oanagradientpara() const {
  return this != internal_default_instance() && oanagradientpara_ != NULL;
}
inline void TestItem::clear_oanagradientpara() {
  if (GetArenaNoVirtual() == NULL && oanagradientpara_ != NULL) delete oanagradientpara_;
  oanagradientpara_ = NULL;
}
inline const ::OutPutCommon::GradientPara& TestItem::oanagradientpara() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.TestItem.oanaGradientpara)
  return oanagradientpara_ != NULL ? *oanagradientpara_
                         : *::OutPutCommon::GradientPara::internal_default_instance();
}
inline ::OutPutCommon::GradientPara* TestItem::mutable_oanagradientpara() {
  
  if (oanagradientpara_ == NULL) {
    oanagradientpara_ = new ::OutPutCommon::GradientPara;
  }
  // @@protoc_insertion_point(field_mutable:ManuTestPara.TestItem.oanaGradientpara)
  return oanagradientpara_;
}
inline ::OutPutCommon::GradientPara* TestItem::release_oanagradientpara() {
  // @@protoc_insertion_point(field_release:ManuTestPara.TestItem.oanaGradientpara)
  
  ::OutPutCommon::GradientPara* temp = oanagradientpara_;
  oanagradientpara_ = NULL;
  return temp;
}
inline void TestItem::set_allocated_oanagradientpara(::OutPutCommon::GradientPara* oanagradientpara) {
  delete oanagradientpara_;
  oanagradientpara_ = oanagradientpara;
  if (oanagradientpara) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:ManuTestPara.TestItem.oanaGradientpara)
}

// .OutPutCommon.GradientPara odigGradientpara = 5;
inline bool TestItem::has_odiggradientpara() const {
  return this != internal_default_instance() && odiggradientpara_ != NULL;
}
inline void TestItem::clear_odiggradientpara() {
  if (GetArenaNoVirtual() == NULL && odiggradientpara_ != NULL) delete odiggradientpara_;
  odiggradientpara_ = NULL;
}
inline const ::OutPutCommon::GradientPara& TestItem::odiggradientpara() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.TestItem.odigGradientpara)
  return odiggradientpara_ != NULL ? *odiggradientpara_
                         : *::OutPutCommon::GradientPara::internal_default_instance();
}
inline ::OutPutCommon::GradientPara* TestItem::mutable_odiggradientpara() {
  
  if (odiggradientpara_ == NULL) {
    odiggradientpara_ = new ::OutPutCommon::GradientPara;
  }
  // @@protoc_insertion_point(field_mutable:ManuTestPara.TestItem.odigGradientpara)
  return odiggradientpara_;
}
inline ::OutPutCommon::GradientPara* TestItem::release_odiggradientpara() {
  // @@protoc_insertion_point(field_release:ManuTestPara.TestItem.odigGradientpara)
  
  ::OutPutCommon::GradientPara* temp = odiggradientpara_;
  odiggradientpara_ = NULL;
  return temp;
}
inline void TestItem::set_allocated_odiggradientpara(::OutPutCommon::GradientPara* odiggradientpara) {
  delete odiggradientpara_;
  odiggradientpara_ = odiggradientpara;
  if (odiggradientpara) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:ManuTestPara.TestItem.odigGradientpara)
}

// .ManuTestPara.SwitchPara oswitchpara = 6;
inline bool TestItem::has_oswitchpara() const {
  return this != internal_default_instance() && oswitchpara_ != NULL;
}
inline void TestItem::clear_oswitchpara() {
  if (GetArenaNoVirtual() == NULL && oswitchpara_ != NULL) delete oswitchpara_;
  oswitchpara_ = NULL;
}
inline const ::ManuTestPara::SwitchPara& TestItem::oswitchpara() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.TestItem.oswitchpara)
  return oswitchpara_ != NULL ? *oswitchpara_
                         : *::ManuTestPara::SwitchPara::internal_default_instance();
}
inline ::ManuTestPara::SwitchPara* TestItem::mutable_oswitchpara() {
  
  if (oswitchpara_ == NULL) {
    oswitchpara_ = new ::ManuTestPara::SwitchPara;
  }
  // @@protoc_insertion_point(field_mutable:ManuTestPara.TestItem.oswitchpara)
  return oswitchpara_;
}
inline ::ManuTestPara::SwitchPara* TestItem::release_oswitchpara() {
  // @@protoc_insertion_point(field_release:ManuTestPara.TestItem.oswitchpara)
  
  ::ManuTestPara::SwitchPara* temp = oswitchpara_;
  oswitchpara_ = NULL;
  return temp;
}
inline void TestItem::set_allocated_oswitchpara(::ManuTestPara::SwitchPara* oswitchpara) {
  delete oswitchpara_;
  oswitchpara_ = oswitchpara;
  if (oswitchpara) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:ManuTestPara.TestItem.oswitchpara)
}

// -------------------------------------------------------------------

// realPara

// .OutPutCommon.acanalogpara oacanlogpara = 1;
inline bool realPara::has_oacanlogpara() const {
  return this != internal_default_instance() && oacanlogpara_ != NULL;
}
inline void realPara::clear_oacanlogpara() {
  if (GetArenaNoVirtual() == NULL && oacanlogpara_ != NULL) delete oacanlogpara_;
  oacanlogpara_ = NULL;
}
inline const ::OutPutCommon::acanalogpara& realPara::oacanlogpara() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.realPara.oacanlogpara)
  return oacanlogpara_ != NULL ? *oacanlogpara_
                         : *::OutPutCommon::acanalogpara::internal_default_instance();
}
inline ::OutPutCommon::acanalogpara* realPara::mutable_oacanlogpara() {
  
  if (oacanlogpara_ == NULL) {
    oacanlogpara_ = new ::OutPutCommon::acanalogpara;
  }
  // @@protoc_insertion_point(field_mutable:ManuTestPara.realPara.oacanlogpara)
  return oacanlogpara_;
}
inline ::OutPutCommon::acanalogpara* realPara::release_oacanlogpara() {
  // @@protoc_insertion_point(field_release:ManuTestPara.realPara.oacanlogpara)
  
  ::OutPutCommon::acanalogpara* temp = oacanlogpara_;
  oacanlogpara_ = NULL;
  return temp;
}
inline void realPara::set_allocated_oacanlogpara(::OutPutCommon::acanalogpara* oacanlogpara) {
  delete oacanlogpara_;
  oacanlogpara_ = oacanlogpara;
  if (oacanlogpara) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:ManuTestPara.realPara.oacanlogpara)
}

// .OutPutCommon.acanalogpara oacdigitalpara = 2;
inline bool realPara::has_oacdigitalpara() const {
  return this != internal_default_instance() && oacdigitalpara_ != NULL;
}
inline void realPara::clear_oacdigitalpara() {
  if (GetArenaNoVirtual() == NULL && oacdigitalpara_ != NULL) delete oacdigitalpara_;
  oacdigitalpara_ = NULL;
}
inline const ::OutPutCommon::acanalogpara& realPara::oacdigitalpara() const {
  // @@protoc_insertion_point(field_get:ManuTestPara.realPara.oacdigitalpara)
  return oacdigitalpara_ != NULL ? *oacdigitalpara_
                         : *::OutPutCommon::acanalogpara::internal_default_instance();
}
inline ::OutPutCommon::acanalogpara* realPara::mutable_oacdigitalpara() {
  
  if (oacdigitalpara_ == NULL) {
    oacdigitalpara_ = new ::OutPutCommon::acanalogpara;
  }
  // @@protoc_insertion_point(field_mutable:ManuTestPara.realPara.oacdigitalpara)
  return oacdigitalpara_;
}
inline ::OutPutCommon::acanalogpara* realPara::release_oacdigitalpara() {
  // @@protoc_insertion_point(field_release:ManuTestPara.realPara.oacdigitalpara)
  
  ::OutPutCommon::acanalogpara* temp = oacdigitalpara_;
  oacdigitalpara_ = NULL;
  return temp;
}
inline void realPara::set_allocated_oacdigitalpara(::OutPutCommon::acanalogpara* oacdigitalpara) {
  delete oacdigitalpara_;
  oacdigitalpara_ = oacdigitalpara;
  if (oacdigitalpara) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:ManuTestPara.realPara.oacdigitalpara)
}

#endif  // !PROTOBUF_INLINE_NOT_IN_HEADERS
// -------------------------------------------------------------------

// -------------------------------------------------------------------

// -------------------------------------------------------------------


// @@protoc_insertion_point(namespace_scope)


}  // namespace ManuTestPara

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_manuTest_2eproto__INCLUDED
