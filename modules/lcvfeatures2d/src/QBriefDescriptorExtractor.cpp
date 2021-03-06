#include "QBriefDescriptorExtractor.hpp"
#include "opencv2/features2d/features2d.hpp"

QBriefDescriptorExtractor::QBriefDescriptorExtractor(QQuickItem *parent)
    : QDescriptorExtractor(new cv::BriefDescriptorExtractor, parent)
{
}

QBriefDescriptorExtractor::~QBriefDescriptorExtractor(){
}

void QBriefDescriptorExtractor::initialize(int bytes){
    initializeExtractor(new cv::BriefDescriptorExtractor(bytes));
}
