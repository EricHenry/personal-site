module Layout exposing (view)

import DocumentSvg
import Element exposing (Element, rgb255)
import Element.Background
import Element.Border
import Element.Font as Font
import Element.Region
import Html exposing (Html)
import Metadata exposing (Metadata)
import Pages
import Pages.Directory as Directory exposing (Directory)
import Pages.ImagePath as ImagePath
import Pages.PagePath as PagePath exposing (PagePath)
import Palette


view :
    { title : String, body : List (Element msg) }
    ->
        { path : PagePath Pages.PathKey
        , frontmatter : Metadata
        }
    -> { title : String, body : Html msg }
view document page =
    { title = document.title
    , body =
        Element.column
            [ Element.Background.color (rgb255 28 32 34)
            , Font.color (rgb255 201 202 204)
            , Element.width Element.fill
            , Element.height Element.fill
            ]
            [ header page.path
            , Element.column
                [ Element.padding 30
                , Element.spacing 40
                , Element.Region.mainContent
                , Element.width (Element.fill |> Element.maximum 800)
                , Element.height Element.fill
                , Element.centerX
                ]
                document.body
            , footer
            ]
            |> Element.layout
                [ Element.width Element.fill
                , Font.size 20
                , Font.family [ Font.typeface "Menlo" ]
                , Font.color (Element.rgba255 0 0 0 0.8)
                ]
    }


header : PagePath Pages.PathKey -> Element msg
header currentPath =
    Element.column [ Element.width Element.fill ]
        [ Element.row
            [ Element.width Element.fill
            , Element.Region.navigation
            , Element.Border.widthEach { bottom = 0, left = 0, right = 0, top = 1 }
            , Element.Border.color (Element.rgb255 201 202 204)
            ]
            [ Element.row
                [ Element.paddingXY 25 25
                , Element.centerX
                , Element.spaceEvenly
                , Element.width (Element.maximum 800 Element.fill)
                ]
                [ Element.link []
                    { url = "/"
                    , label =
                        Element.row [ Font.size 28, Element.spacing 16 ] [ Element.text "eh." ]
                    }
                , Element.row [ Element.spacing 15 ]
                    [ githubRepoLink
                    , linkedInLink
                    ]
                ]
            ]
        ]


footer : Element msg
footer =
    Element.column [ Element.width Element.fill ]
        [ Element.row
            [ Element.width Element.fill
            , Element.Region.footer
            ]
            [ Element.row
                [ Element.paddingXY 25 15
                , Font.size 12
                , Element.centerX
                , Element.spacing 10
                , Element.width (Element.maximum 800 Element.fill)
                , Font.color (rgb255 102 102 102)
                ]
                [ Element.el [] (Element.text "copyright © 2021 eric henry")
                , Element.row
                    [ Element.alignRight
                    ]
                    [ Element.text "written in: "
                    , elmLink
                    ]
                ]
            ]
        ]


highlightableLink :
    PagePath Pages.PathKey
    -> Directory Pages.PathKey Directory.WithIndex
    -> String
    -> Element msg
highlightableLink currentPath linkDirectory displayName =
    let
        isHighlighted =
            currentPath |> Directory.includes linkDirectory
    in
    Element.link
        (if isHighlighted then
            [ Font.underline
            , Font.color Palette.color.primary
            ]

         else
            []
        )
        { url = linkDirectory |> Directory.indexPath |> PagePath.toString
        , label = Element.text displayName
        }


githubRepoLink : Element msg
githubRepoLink =
    Element.newTabLink []
        { url = "https://github.com/erichenry"
        , label =
            Element.image
                [ Element.width (Element.px 28)
                , Font.color Palette.color.primary
                ]
                { src = ImagePath.toString Pages.images.octocat, description = "Github Profile" }
        }


linkedInLink : Element msg
linkedInLink =
    Element.newTabLink []
        { url = "https://www.linkedin.com/in/eric-henry-correia/"
        , label =
            Element.image
                [ Element.width (Element.px 28)
                , Font.color Palette.color.primary
                ]
                { src = ImagePath.toString Pages.images.linkedin, description = "LinkedIn Profile" }
        }


elmLink : Element msg
elmLink =
    Element.newTabLink []
        { url = "https://elm-lang.org/"
        , label =
            Element.image
                [ Element.width (Element.px 18)
                , Font.color Palette.color.primary
                ]
                { src = ImagePath.toString Pages.images.elmLogo, description = "Elm logo" }
        }
