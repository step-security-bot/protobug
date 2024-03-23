# frozen_string_literal: true

# Code generated by protoc-gen-protobug. DO NOT EDIT.

# source: google/protobuf/api.proto
# syntax: proto3
# package: google.protobuf
# options:
#   java_package: "com.google.protobuf"
#   java_outer_classname: "ApiProto"
#   java_multiple_files: true
#   go_package: "google.golang.org/protobuf/types/known/apipb"
#   objc_class_prefix: "GPB"
#   csharp_namespace: "Google.Protobuf.WellKnownTypes"

# Protocol Buffers - Google's data interchange format
# Copyright 2008 Google Inc.  All rights reserved.
# https://developers.google.com/protocol-buffers/
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#     * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following disclaimer
# in the documentation and/or other materials provided with the
# distribution.
#     * Neither the name of Google Inc. nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

require "protobug"

require_relative "source_context_pb"
require_relative "type_pb"

module Google
  module Protobuf
    # Api is a light-weight descriptor for an API Interface.
    #
    # Interfaces are also described as "protocol buffer services" in some contexts,
    # such as by the "service" keyword in a .proto file, but they are different
    # from API Services, which represent a concrete implementation of an interface
    # as opposed to simply a description of methods and bindings. They are also
    # sometimes simply referred to as "APIs" in other contexts, such as the name of
    # this message itself. See https://cloud.google.com/apis/design/glossary for
    # detailed terminology.
    class Api
      extend Protobug::Message

      self.full_name = "google.protobuf.Api"

      # The fully qualified name of this interface, including package name
      # followed by the interface's simple name.
      optional(1, "name", type: :string, proto3_optional: false)
      # The methods of this interface, in unspecified order.
      repeated(
        2,
        "methods",
        type: :message,
        message_type: "google.protobuf.Method"
      )
      # Any metadata attached to the interface.
      repeated(
        3,
        "options",
        type: :message,
        message_type: "google.protobuf.Option"
      )
      # A version string for this interface. If specified, must have the form
      # `major-version.minor-version`, as in `1.10`. If the minor version is
      # omitted, it defaults to zero. If the entire version field is empty, the
      # major version is derived from the package name, as outlined below. If the
      # field is not empty, the version in the package name will be verified to be
      # consistent with what is provided here.
      #
      # The versioning schema uses [semantic
      # versioning](http://semver.org) where the major version number
      # indicates a breaking change and the minor version an additive,
      # non-breaking change. Both version numbers are signals to users
      # what to expect from different versions, and should be carefully
      # chosen based on the product plan.
      #
      # The major version is also reflected in the package name of the
      # interface, which must end in `v<major-version>`, as in
      # `google.feature.v1`. For major versions 0 and 1, the suffix can
      # be omitted. Zero major versions must only be used for
      # experimental, non-GA interfaces.
      optional(4, "version", type: :string, proto3_optional: false)
      # Source context for the protocol buffer service represented by this
      # message.
      optional(
        5,
        "source_context",
        type: :message,
        message_type: "google.protobuf.SourceContext",
        json_name: "sourceContext",
        proto3_optional: false
      )
      # Included interfaces. See [Mixin][].
      repeated(
        6,
        "mixins",
        type: :message,
        message_type: "google.protobuf.Mixin"
      )
      # The source syntax of the service.
      optional(
        7,
        "syntax",
        type: :enum,
        enum_type: "google.protobuf.Syntax",
        proto3_optional: false
      )
    end

    # Method represents a method of an API interface.
    class Method
      extend Protobug::Message

      self.full_name = "google.protobuf.Method"

      # The simple name of this method.
      optional(1, "name", type: :string, proto3_optional: false)
      # A URL of the input message type.
      optional(
        2,
        "request_type_url",
        type: :string,
        json_name: "requestTypeUrl",
        proto3_optional: false
      )
      # If true, the request is streamed.
      optional(
        3,
        "request_streaming",
        type: :bool,
        json_name: "requestStreaming",
        proto3_optional: false
      )
      # The URL of the output message type.
      optional(
        4,
        "response_type_url",
        type: :string,
        json_name: "responseTypeUrl",
        proto3_optional: false
      )
      # If true, the response is streamed.
      optional(
        5,
        "response_streaming",
        type: :bool,
        json_name: "responseStreaming",
        proto3_optional: false
      )
      # Any metadata attached to the method.
      repeated(
        6,
        "options",
        type: :message,
        message_type: "google.protobuf.Option"
      )
      # The source syntax of this method.
      optional(
        7,
        "syntax",
        type: :enum,
        enum_type: "google.protobuf.Syntax",
        proto3_optional: false
      )
    end

    # Declares an API Interface to be included in this interface. The including
    # interface must redeclare all the methods from the included interface, but
    # documentation and options are inherited as follows:
    #
    # - If after comment and whitespace stripping, the documentation
    #   string of the redeclared method is empty, it will be inherited
    #   from the original method.
    #
    # - Each annotation belonging to the service config (http,
    #   visibility) which is not set in the redeclared method will be
    #   inherited.
    #
    # - If an http annotation is inherited, the path pattern will be
    #   modified as follows. Any version prefix will be replaced by the
    #   version of the including interface plus the [root][] path if
    #   specified.
    #
    # Example of a simple mixin:
    #
    #     package google.acl.v1;
    #     service AccessControl {
    #       // Get the underlying ACL object.
    #       rpc GetAcl(GetAclRequest) returns (Acl) {
    #         option (google.api.http).get = "/v1/{resource=**}:getAcl";
    #       }
    #     }
    #
    #     package google.storage.v2;
    #     service Storage {
    #       rpc GetAcl(GetAclRequest) returns (Acl);
    #
    #       // Get a data record.
    #       rpc GetData(GetDataRequest) returns (Data) {
    #         option (google.api.http).get = "/v2/{resource=**}";
    #       }
    #     }
    #
    # Example of a mixin configuration:
    #
    #     apis:
    #     - name: google.storage.v2.Storage
    #       mixins:
    #       - name: google.acl.v1.AccessControl
    #
    # The mixin construct implies that all methods in `AccessControl` are
    # also declared with same name and request/response types in
    # `Storage`. A documentation generator or annotation processor will
    # see the effective `Storage.GetAcl` method after inherting
    # documentation and annotations as follows:
    #
    #     service Storage {
    #       // Get the underlying ACL object.
    #       rpc GetAcl(GetAclRequest) returns (Acl) {
    #         option (google.api.http).get = "/v2/{resource=**}:getAcl";
    #       }
    #       ...
    #     }
    #
    # Note how the version in the path pattern changed from `v1` to `v2`.
    #
    # If the `root` field in the mixin is specified, it should be a
    # relative path under which inherited HTTP paths are placed. Example:
    #
    #     apis:
    #     - name: google.storage.v2.Storage
    #       mixins:
    #       - name: google.acl.v1.AccessControl
    #         root: acls
    #
    # This implies the following inherited HTTP annotation:
    #
    #     service Storage {
    #       // Get the underlying ACL object.
    #       rpc GetAcl(GetAclRequest) returns (Acl) {
    #         option (google.api.http).get = "/v2/acls/{resource=**}:getAcl";
    #       }
    #       ...
    #     }
    class Mixin
      extend Protobug::Message

      self.full_name = "google.protobuf.Mixin"

      # The fully qualified name of the interface which is included.
      optional(1, "name", type: :string, proto3_optional: false)
      # If non-empty specifies a path under which inherited HTTP paths
      # are rooted.
      optional(2, "root", type: :string, proto3_optional: false)
    end

    def self.register_api_protos(registry)
      Google::Protobuf.register_source_context_protos(registry)
      Google::Protobuf.register_type_protos(registry)
      registry.register(Google::Protobuf::Api)
      registry.register(Google::Protobuf::Method)
      registry.register(Google::Protobuf::Mixin)
    end
  end
end
