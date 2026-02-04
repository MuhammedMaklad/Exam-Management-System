import { RadioGroup as ChakraRadioGroup } from '@chakra-ui/react'
import * as React from 'react'

export interface RadioGroupProps extends ChakraRadioGroup.RootProps { }

export const RadioGroup = React.forwardRef<HTMLDivElement, RadioGroupProps>(
    function RadioGroup(props, ref) {
        return <ChakraRadioGroup.Root ref={ref} {...props} />
    },
)

export const Radio = React.forwardRef<HTMLInputElement, ChakraRadioGroup.ItemProps>(
    function Radio(props, ref) {
        const { children, ...rest } = props
        return (
            <ChakraRadioGroup.Item {...rest}>
                <ChakraRadioGroup.ItemHiddenInput ref={ref} />
                <ChakraRadioGroup.ItemControl />
                {children && <ChakraRadioGroup.ItemText>{children}</ChakraRadioGroup.ItemText>}
            </ChakraRadioGroup.Item>
        )
    },
)

