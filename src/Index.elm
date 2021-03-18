module Index exposing (view)

import Date
import Element exposing (Element)
import Element.Font
import Metadata exposing (Metadata)
import Pages
import Pages.PagePath as PagePath exposing (PagePath)


type alias PostEntry =
    ( PagePath Pages.PathKey, Metadata.ArticleMetadata )


view :
    List ( PagePath Pages.PathKey, Metadata )
    -> Element msg
view posts =
    Element.column [ Element.spacing 20 ]
        (posts
            |> List.filterMap
                (\( path, metadata ) ->
                    case metadata of
                        Metadata.Page meta ->
                            Nothing

                        Metadata.Author _ ->
                            Nothing

                        Metadata.Article meta ->
                            if meta.draft then
                                Nothing

                            else
                                Just ( path, meta )

                        Metadata.BlogIndex ->
                            Nothing
                )
            |> List.sortWith postPublishDateDescending
            |> List.map postSummary
        )


postPublishDateDescending : PostEntry -> PostEntry -> Order
postPublishDateDescending ( _, metadata1 ) ( _, metadata2 ) =
    Date.compare metadata2.published metadata1.published


postSummary : PostEntry -> Element msg
postSummary ( postPath, post ) =
    articleIndex post
        |> linkToPost postPath


linkToPost : PagePath Pages.PathKey -> Element msg -> Element msg
linkToPost postPath content =
    Element.link [ Element.width Element.fill ]
        { url = PagePath.toString postPath, label = content }


title : String -> Element msg
title text =
    [ Element.text text ]
        |> Element.paragraph
            [ Element.Font.size 16
            , Element.Font.underline
            , Element.Font.color (Element.rgb255 201 202 204)
            , Element.padding 16
            ]


articleIndex : Metadata.ArticleMetadata -> Element msg
articleIndex metadata =
    Element.row [ Element.alignLeft ]
        [ Element.el
            [ Element.Font.color (Element.rgb255 102 102 102)
            , Element.Font.size 14
            ]
            (Element.text (metadata.published |> Date.format "yyyy-dd-MM"))
        , title metadata.title
        ]
