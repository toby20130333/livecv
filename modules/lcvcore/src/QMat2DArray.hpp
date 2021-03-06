/****************************************************************************
**
** Copyright (C) 2014 Dinu SV.
** (contact: mail@dinusv.com)
** This file is part of Live CV application.
**
** GNU General Public License Usage
** 
** This file may be used under the terms of the GNU General Public License 
** version 3.0 as published by the Free Software Foundation and appearing 
** in the file LICENSE.GPL included in the packaging of this file.  Please 
** review the following information to ensure the GNU General Public License 
** version 3.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.
**
****************************************************************************/

#ifndef QMAT2DARRAY_HPP
#define QMAT2DARRAY_HPP

#include "QMatDisplay.hpp"
#include "QLCVGlobal.hpp"
#include <QList>

class QMat2DArray : public QMatDisplay{

    Q_OBJECT
    Q_PROPERTY(QVariantList values READ values WRITE setValues NOTIFY valuesChanged)
    Q_PROPERTY(QMat::Type   type   READ type   WRITE setType   NOTIFY typeChanged)

public:
    explicit QMat2DArray(QQuickItem *parent = 0);
    ~QMat2DArray();

    const QVariantList& values() const;
    void setValues( const QVariantList& val );

    QMat::Type type() const;
    void setType(QMat::Type type);

    cv::Size assignValues();

signals:
    void valuesChanged();
    void typeChanged();

private:
    QMat::Type   m_type;
    QVariantList m_values;

    cv::Size     m_cachedSize;

};

inline const QVariantList &QMat2DArray::values() const{
    return m_values;
}

inline void QMat2DArray::setValues(const QVariantList &val){
    if ( val != m_values ){
        m_values     = val;
        m_cachedSize = assignValues();
        emit valuesChanged();
        emit outputChanged();
        update();
    }
}

inline QMat::Type QMat2DArray::type() const{
    return m_type;
}

inline void QMat2DArray::setType(QMat::Type type){
    if ( m_type != type ){
        m_type = type;
        emit typeChanged();
        if ( m_cachedSize != cv::Size(0,0) ){
            assignValues();
            emit outputChanged();
            update();
        }
    }
}

#endif // QMAT2DARRAY_HPP
