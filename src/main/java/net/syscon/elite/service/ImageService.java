package net.syscon.elite.service;


import net.syscon.elite.api.model.ImageDetail;

public interface ImageService {

    ImageDetail findImageDetail(Long imageId);

    byte[] getImageContent(Long imageId, boolean fullSizeImage);

    byte[] getImageContent(String offenderNo, boolean fullSizeImage);
}

