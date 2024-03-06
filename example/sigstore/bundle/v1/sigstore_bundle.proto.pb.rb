# frozen_string_literal: true
# Code generated by protoc-gen-protobug. DO NOT EDIT.


# source: sigstore_bundle.proto
# syntax: proto3
# package: dev.sigstore.bundle.v1
# options:
#   java_package: "dev.sigstore.proto.bundle.v1"
#   java_outer_classname: "BundleProto"
#   java_multiple_files: true
#   go_package: "github.com/sigstore/protobuf-specs/gen/pb-go/bundle/v1"
#   ruby_package: "Sigstore::Bundle::V1"

# Copyright 2022 The Sigstore Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "protobug"

require "google/api/field_behavior.proto.pb.rb"
require "sigstore/dsse/envelope.proto.pb.rb"
require "sigstore/common/v1/sigstore_common.proto.pb.rb"
require "sigstore/rekor/v1/sigstore_rekor.proto.pb.rb"

module Sigstore
  module Bundle
    module V1
      # Notes on versioning.
      # The primary message ('Bundle') MUST be versioned, by populating the
      # 'media_type' field. Semver-ish (only major/minor versions) scheme MUST
      # be used. The current version as specified by this file is:
      # application/vnd.dev.sigstore.bundle+json;version=0.3
      # The semantic version is thus '0.3'.

      # Various timestamped counter signatures over the artifacts signature.
      # Currently only RFC3161 signatures are provided. More formats may be added
      # in the future.
      class TimestampVerificationData
        extend Protobug::Message

        self.full_name = "dev.sigstore.bundle.v1.TimestampVerificationData"

        # A list of RFC3161 signed timestamps provided by the user.
        # This can be used when the entry has not been stored on a
        # transparency log, or in conjunction for a stronger trust model.
        # Clients MUST verify the hashed message in the message imprint
        # against the signature in the bundle.
        repeated(1, "rfc3161_timestamps", type: :message, message_type: "dev.sigstore.common.v1.RFC3161SignedTimestamp", json_name: "rfc3161Timestamps")
      end

      # VerificationMaterial captures details on the materials used to verify
      # signatures. This message may be embedded in a DSSE envelope as a signature
      # extension. Specifically, the `ext` field of the extension will expect this
      # message when the signature extension is for Sigstore. This is identified by
      # the `kind` field in the extension, which must be set to
      # application/vnd.dev.sigstore.verificationmaterial;version=0.1 for Sigstore.
      # When used as a DSSE extension, if the `public_key` field is used to indicate
      # the key identifier, it MUST match the `keyid` field of the signature the
      # extension is attached to.
      class VerificationMaterial
        extend Protobug::Message

        self.full_name = "dev.sigstore.bundle.v1.VerificationMaterial"

        # The key material for verification purposes.
        #
        # This allows key material to be conveyed in one of three forms:
        #
        # 1. An unspecified public key identifier, for retrieving a key
        #    from an out-of-band mechanism (such as a keyring);
        #
        # 2. A sequence of one or more X.509 certificates, of which the first member
        #    MUST be a leaf certificate conveying the signing key. Subsequent members
        #    SHOULD be in issuing order, meaning that `n + 1` should be an issuer for `n`.
        #
        #    Signers MUST NOT include root CA certificates in bundles, and SHOULD NOT
        #    include intermediate CA certificates that appear in an independent root of trust
        #    (such as the Public Good Instance's trusted root).
        #
        #    Verifiers MUST validate the chain carefully to ensure that it chains up
        #    to a CA certificate that they independently trust. Verifiers SHOULD
        #    handle old or non-complying bundles that have superfluous intermediate and/or
        #    root CA certificates by either ignoring them or explicitly considering them
        #    untrusted for the purposes of chain building.
        #
        # 3. A single X.509 certificate, which MUST be a leaf certificate conveying
        #    the signing key.
        #
        # When used with the Public Good Instance (PGI) of Sigstore for "keyless" signing
        # via Fulcio, form (1) MUST NOT be used, regardless of bundle version. Form (1)
        # MAY be used with the PGI for self-managed keys.
        #
        # When used in a `0.1` or `0.2` bundle with the PGI and "keyless" signing,
        # form (2) MUST be used.
        #
        # When used in a `0.3` bundle with the PGI and "keyless" signing,
        # form (3) MUST be used.

        optional(1, "public_key", type: :message, message_type: "dev.sigstore.common.v1.PublicKeyIdentifier", json_name: "publicKey", oneof: :content)
        optional(2, "x509_certificate_chain", type: :message, message_type: "dev.sigstore.common.v1.X509CertificateChain", json_name: "x509CertificateChain", oneof: :content)
        optional(5, "certificate", type: :message, message_type: "dev.sigstore.common.v1.X509Certificate", oneof: :content)
        # An inclusion proof and an optional signed timestamp from the log.
        # Client verification libraries MAY provide an option to support v0.1
        # bundles for backwards compatibility, which may contain an inclusion
        # promise and not an inclusion proof. In this case, the client MUST
        # validate the promise.
        # Verifiers SHOULD NOT allow v0.1 bundles if they're used in an
        # ecosystem which never produced them.
        repeated(3, "tlog_entries", type: :message, message_type: "dev.sigstore.rekor.v1.TransparencyLogEntry", json_name: "tlogEntries")
        # Timestamp may also come from
        # tlog_entries.inclusion_promise.signed_entry_timestamp.
        optional(4, "timestamp_verification_data", type: :message, message_type: "dev.sigstore.bundle.v1.TimestampVerificationData", json_name: "timestampVerificationData")
      end

      class Bundle
        extend Protobug::Message

        self.full_name = "dev.sigstore.bundle.v1.Bundle"

        # MUST be application/vnd.dev.sigstore.bundle+json;version=0.1
        # or application/vnd.dev.sigstore.bundle+json;version=0.2
        # or application/vnd.dev.sigstore.bundle+json;version=0.3
        # when encoded as JSON.
        optional(1, "media_type", type: :string, json_name: "mediaType")
        # When a signer is identified by a X.509 certificate, a verifier MUST
        # verify that the signature was computed at the time the certificate
        # was valid as described in the Sigstore client spec: "Verification
        # using a Bundle".
        # <https://docs.google.com/document/d/1kbhK2qyPPk8SLavHzYSDM8-Ueul9_oxIMVFuWMWKz0E/edit#heading=h.x8bduppe89ln>
        # If the verification material contains a public key identifier
        # (key hint) and the `content` is a DSSE envelope, the key hints
        # MUST be exactly the same in the verification material and in the
        # DSSE envelope.
        optional(2, "verification_material", type: :message, message_type: "dev.sigstore.bundle.v1.VerificationMaterial", json_name: "verificationMaterial")

        optional(3, "message_signature", type: :message, message_type: "dev.sigstore.common.v1.MessageSignature", json_name: "messageSignature", oneof: :content)
        # A DSSE envelope can contain arbitrary payloads.
        # Verifiers must verify that the payload type is a
        # supported and expected type. This is part of the DSSE
        # protocol which is defined here:
        # <https://github.com/secure-systems-lab/dsse/blob/master/protocol.md>
        optional(4, "dsse_envelope", type: :message, message_type: "io.intoto.Envelope", json_name: "dsseEnvelope", oneof: :content)

        # Reserved for future additions of artifact types.
        reserved_range(5...51)
      end

      def self.register_sigstore_bundle_protos(registry)
        Google::Api.register_field_behavior_protos(registry)
        Sigstore::DSSE.register_envelope_protos(registry)
        Sigstore::Common::V1.register_sigstore_common_protos(registry)
        Sigstore::Rekor::V1.register_sigstore_rekor_protos(registry)
        registry.register(Sigstore::Bundle::V1::TimestampVerificationData)
        registry.register(Sigstore::Bundle::V1::VerificationMaterial)
        registry.register(Sigstore::Bundle::V1::Bundle)
      end
    end
  end
end
