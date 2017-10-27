import CoreLocation

/// File uploading target
public enum UploadTarget {
    case user(id: String)
    case group(id: String)

    var decoded: (userId: String?, groupId: String?) {
        switch self {
        case .user(let id):
            return (userId: id, groupId: nil)
        case .group(let id):
            return (userId: nil, groupId: id)
        }
    }
}

// swiftlint:disable next nesting
extension APIScope {
    //Metods to upload Mediafiles. More info - https://vk.com/dev/upload_files
    public struct Upload {
        ///Methods to upload photo
        public struct Photo {
            ///Upload photo to user album
            public static func toAlbum(
                _ media: [Media],
                to target: UploadTarget,
                albumId: String,
                caption: String? = nil,
                location: CLLocationCoordinate2D? = nil
                ) -> Methods.SuccessableFailableProgressableConfigurable {
                
                let method = APIScope.Photos.getUploadServer([
                    .albumId: albumId,
                    .userId: target.decoded.userId,
                    .groupId: target.decoded.groupId
                    ])
                    .chain {
                        let response = try JSON(data: $0)
                        
                        return Request(
                            type: .upload(
                                url: response.forcedString("upload_url"),
                                media: Array(media.prefix(5)),
                                partType: .indexedFile
                            ),
                            config: .upload
                            )
                            .toMethod()
                    }
                    .chain {
                        let response = try JSON(data: $0)
                        
                        return APIScope.Photos.save([
                            .albumId: albumId,
                            .userId: target.decoded.userId,
                            .groupId: target.decoded.groupId,
                            .server: response.forcedInt("server").toString(),
                            .photosList: response.forcedString("photos_list"),
                            .aid: response.forcedInt("aid").toString(),
                            .hash: response.forcedString("hash"),
                            .caption: caption,
                            .latitude: location?.latitude.toString(),
                            .longitude: location?.longitude.toString()
                            ])
                    }
                
                return Methods.SuccessableFailableProgressableConfigurable(method.request)
            }
            
            /// Upload photo for using in messages.send method
            public static func toMessage(_ media: Media) -> Methods.SuccessableFailableProgressableConfigurable {
                
                let method = APIScope.Photos.getMessagesUploadServer(.empty)
                    .chain {
                        let response = try JSON(data: $0)
                        
                        return Request(
                            type: .upload(
                                url: response.forcedString("upload_url"),
                                media: [media],
                                partType: .photo
                            ),
                            config: .upload
                            )
                            .toMethod()
                    }
                    .chain {
                        let response = try JSON(data: $0)
                        
                        return APIScope.Photos.saveMessagesPhoto([
                            .photo: response.forcedString("photo"),
                            .server: response.forcedInt("server").toString(),
                            .hash: response.forcedString("hash")
                            ])
                    }
                
                return Methods.SuccessableFailableProgressableConfigurable(method.request)
            }
            
            /// Upload photo for using in market.add or market.edit methods
            public static func toMarket(
                _ media: Media,
                mainPhotoConfig: (cropX: String?, cropY: String?, cropW: String?)?,
                groupId: String
                ) -> Methods.SuccessableFailableProgressableConfigurable {
                
                let method = APIScope.Photos.getMarketUploadServer([.groupId: groupId])
                    .chain {
                        let response = try JSON(data: $0)
                        
                        return Request(
                            type: .upload(
                                url: response.forcedString("upload_url"),
                                media: [media],
                                partType: .file
                            ),
                            config: .upload
                            )
                            .toMethod()
                    }
                    .chain {
                        let response = try JSON(data: $0)
                        
                        return APIScope.Photos.saveMarketPhoto([
                            .groupId: groupId,
                            .photo: response.forcedString("photo"),
                            .server: response.forcedInt("server").toString(),
                            .hash: response.forcedString("hash"),
                            .cropData: response.forcedString("crop_data"),
                            .cropHash: response.forcedString("crop_hash"),
                            .mainPhoto: (mainPhotoConfig != nil ? "1" : "0"),
                            .cropX: mainPhotoConfig?.cropX,
                            .cropY: mainPhotoConfig?.cropY,
                            .cropWidth: mainPhotoConfig?.cropW
                            ])
                    }
                
                return Methods.SuccessableFailableProgressableConfigurable(method.request)
            }
            
            /// Upload photo for using in market.addAlbum or market.editAlbum methods
            public static func toMarketAlbum(
                _ media: Media,
                groupId: String
                ) -> Methods.SuccessableFailableProgressableConfigurable {
                
                let method = APIScope.Photos.getMarketAlbumUploadServer([.groupId: groupId])
                    .chain {
                        let response = try JSON(data: $0)
                        
                        return Request(
                            type: .upload(
                                url: response.forcedString("upload_url"),
                                media: [media],
                                partType: .file
                            ),
                            config: .upload
                            )
                            .toMethod()
                    }
                    .chain {
                        let response = try JSON(data: $0)
                        
                        return APIScope.Photos.saveMarketAlbumPhoto([
                            .groupId: groupId,
                            .photo: response.forcedString("photo"),
                            .server: response.forcedInt("server").toString(),
                            .hash: response.forcedString("hash")
                            ])
                    }
                
                return Methods.SuccessableFailableProgressableConfigurable(method.request)
            }
            
            /// Upload photo for using in wall.post method
            public static func toWall(
                _ media: Media,
                to target: UploadTarget
                ) -> Methods.SuccessableFailableProgressableConfigurable {
                
                let method = APIScope.Photos.getWallUploadServer([
                    .userId: target.decoded.userId,
                    .groupId: target.decoded.groupId
                    ])
                    .chain {
                        let response = try JSON(data: $0)
                        
                        return Request(
                            type: .upload(
                                url: response.forcedString("upload_url"),
                                media: [media],
                                partType: .photo
                            ),
                            config: .upload
                            )
                            .toMethod()
                    }
                    .chain {
                        let response = try JSON(data: $0)
                        
                        return APIScope.Photos.saveWallPhoto([
                            .userId: target.decoded.userId,
                            .groupId: target.decoded.groupId,
                            .photo: response.forcedString("photo"),
                            .server: response.forcedInt("server").toString(),
                            .hash: response.forcedString("hash")
                            ])
                    }
                
                return Methods.SuccessableFailableProgressableConfigurable(method.request)
            }
        }

        /// Upload video file to "my videos"
        public static func video(
            _ media: Media,
            savingParams: Parameters = .empty
            ) -> Methods.SuccessableFailableProgressableConfigurable {
            
            let method = APIScope.Video.save(savingParams)
                .chain {
                    let response = try JSON(data: $0)
                    
                    return Request(
                        type: .upload(
                            url: response.forcedString("upload_url"),
                            media: [media],
                            partType: .video
                        ),
                        config: .upload
                        )
                        .toMethod()
                }
            
            return Methods.SuccessableFailableProgressableConfigurable(method.request)
        }

        /// Upload audio to "My audios"
        public static func audio(
            _ media: Media,
            artist: String? = nil,
            title: String? = nil
            ) -> Methods.SuccessableFailableProgressableConfigurable {
            
            let method = APIScope.Audio.getUploadServer(.empty)
                .chain {
                    let response = try JSON(data: $0)

                    return Request(
                        type: .upload(
                            url: response.forcedString("upload_url"),
                            media: [media],
                            partType: .file
                        ),
                        config: .upload
                        )
                        .toMethod()
                }
                .chain {
                    let response = try JSON(data: $0)

                    return APIScope.Audio.save([
                        .audio: response.forcedString("audio"),
                        .server: response.forcedInt("server").toString(),
                        .hash: response.forcedString("hash"),
                        .artist: artist,
                        .title: title
                        ])
                }
            
            return Methods.SuccessableFailableProgressableConfigurable(method.request)
        }

        ///Upload document
        public static func document(
            _ media: Media,
            groupId: String? = nil,
            title: String? = nil,
            tags: String? = nil
            ) -> Methods.SuccessableFailableProgressableConfigurable {
            
            let method = APIScope.Docs.getUploadServer([.groupId: groupId])
                .chain {
                    let response = try JSON(data: $0)
                    
                    return Request(
                        type: .upload(
                            url: response.forcedString("upload_url"),
                            media: [media],
                            partType: .file
                        ),
                        config: .upload
                        )
                        .toMethod()
                }
                .chain {
                    let response = try JSON(data: $0)
                    
                    return APIScope.Docs.save([
                        .file: response.forcedString("file"),
                        .title: title,
                        .tags: tags
                        ])
                }
            
            return Methods.SuccessableFailableProgressableConfigurable(method.request)
        }
    }
}
